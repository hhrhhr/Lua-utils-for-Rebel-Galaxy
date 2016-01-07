assert("Lua 5.3" == _VERSION)

local in_file = assert(arg[1], "no input")
local out_file = arg[2]


-- binary read
local r
local function sint64(v) return string.unpack("<i8", v or r:read(8)) end
local function uint32(v) return string.unpack("<I4", v or r:read(4)) end
local function sint32(v) return string.unpack("<i4", v or r:read(4)) end
local function uint16(v) return string.unpack("<H",  v or r:read(2)) end
local function uint8(v)  return string.unpack("B",   v or r:read(1)) end
local function float(v)  return string.unpack("f",   v or r:read(4)) end


local function errlog(err)
    io.stderr:write(err)
end


-- dictionaries
local dict_i = {name = "internal"}  -- from current file
local dict_e = {name = "external"}  -- from dict_ext
local dict_t = {name = "types"}     -- from dict_type
local dict_u = {name = "unknown"}   -- TODO: collect all missed keys
local d_use = 1                     -- usage index

local function dict(t, key)
    local k = t[key]
    if t.name == "internal" then
        if not k[4] then
            k[4] = d_use
            d_use = d_use + 1
        end
        k = k[2]
    end

    if k == nil then
        if not dict_u[key] then
            dict_u[key] = 1
            --io.stderr:write("!!! unknown " .. t.name .. " key $" .. key .. "\n")
            errlog("[WARN] unknown " .. t.name .. " key $" .. key .. "\n")
        end
        k = "_" .. key
    end
    return k
end


-- parse
local function read_var()
    local nam = uint32()
    local typ = uint32()
    local val   -- get below

    if     typ == 1 then    -- int
        val = sint32()
    elseif typ == 2 then    -- float
        val = float()
--  elseif typ == 3 then    -- ???
--      val = ???()
--  elseif typ == 4 then    -- ???
--      val = ???()
    elseif typ == 5 then    -- string from internal dict
        val = uint32()
        dict_i[val][3] = "S"    -- mark basic string
    elseif typ == 6 then    -- bool
        val = uint32()
        val = (val == 0) and "false" or "true"
    elseif typ == 7 then    -- int64
        val = sint64()
    elseif typ == 8 then    -- localized string???
        val = uint32()
        dict_i[val][3] = "T"    -- mark localized string
    else
        assert(false, "\n!!! unknown typ " .. typ .. "\n\n")
    end

    nam = dict(dict_e, nam)
    typ = dict(dict_t, typ)
end


local function read_tag()
    local tag = uint32()
    tag = dict(dict_e, tag)

    -- vars
    local num_vars = uint32()
    if num_vars > 0 then
        for _ = 1, num_vars do
            read_var()
        end
    end

    -- inner tags
    local num_tags = uint32()
    if num_tags > 0 then
        for _ = 1, num_tags do
            read_tag()
        end
    end
end

--[[ main ]]--------------------------------------------------------------------

r = assert(io.open(in_file, "rb"))
assert(6 == uint8())

-- generate types dictionary
local d = dofile("dict_types.lua")
for i = 1, #d, 2 do
    dict_t[d[i]] = d[i+1]
end

-- generate external dictionary
d = dofile("dict_ext.lua")
for i = 1, #d, 2 do
    dict_e[d[i]] = d[i+1]
end

-- generate internal dictionary
local count = uint32()

for i = 1, count do
    local idx = uint32()
    local len = uint16()
    -- use escapes
    local str = ("%q"):format(r:read(len))

    local d = dict_i[idx]
    if d ~= nil then
        if d ~= str then
            local fmt = "!!! COLLISION: idx=%d, old=%s, new=%s\n"
            io.stderr:write(fmt:format(idx, d, str))
        end
    end
    dict_i[idx] = { i, str }
end


-- start parse
read_tag(1, 1)


r:close()

-------------------------------------------------------------------------------
local out = io.stdout

if out_file then
    out = assert(io.open(out_file, "w+"))
end

local tmp = {}   -- all

count = 0
for k, v in pairs(dict_i) do
    if type(k) == "number" then -- skip name and size keys
        table.insert(tmp, {k, v})
        count = count + 1
    end
end
table.sort(tmp, function (a, b) return (a[1] < b[1]) end)

local fmt = "%d, %s, %s\n"
for _, v in ipairs(tmp) do
    out:write(fmt:format(v[1], v[2][3], v[2][2]))
    count = count - 1
end

if out_file then
    out:close()
end

assert(count == 0)
