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


-- utils
local function tab(level)
    return ((" "):rep(2 * level))
end

local output = {}
local function tprint(fmt, ...)
    if fmt == "+" then
        -- append ... to last element
        output[#output] = output[#output] .. ...
    else
        -- insert new element
        table.insert(output, fmt:format(...))
    end
end

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
local function read_var(level, idx)
    local nam = uint32()
    local typ = uint32()
    local val   -- get below

    local link
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
        val = dict(dict_i, val)
        --link = dict(dict_i, val)
        --val = "L[" .. val .. "]"
    elseif typ == 6 then    -- bool
        val = uint32()
        val = (val == 0) and "false" or "true"
    elseif typ == 7 then    -- int64
        val = sint64()

    elseif typ == 8 then    -- localized string???
        val = uint32()
        dict_i[val][3] = "L"    -- mark localized string
        link = " --" .. dict(dict_i, val)
--        val = "\"L" .. val .. "\""

    else
        assert(false, "\n!!! unknown typ " .. typ .. "\n\n")
    end

    nam = dict(dict_e, nam)
    typ = dict(dict_t, typ)

    tprint("%s{ n=\"%s\", t=\"%s\", v=%s },%s", tab(level), nam, typ, val, link or "")
end


local function read_tag(level, idx)
    local tag = uint32()
    tag = dict(dict_e, tag)

    -- tag name
    tprint("%sn=\"%s\"", tab(level), tag)

    -- vars
    local num_vars = uint32()
    if num_vars > 0 then
        tprint("+", ",")

        tprint("%svars = {", tab(level))

        for i = 1, num_vars do
            read_var(level+1, i)
        end

        tprint("%s}", tab(level))
    end

    -- inner tags
    local num_tags = uint32()
    if num_tags > 0 then
        tprint("+", ",")

        tprint("%stags = {", tab(level))

        for i = 1, num_tags do
            local level = level + 1
--            tprint("%s[%d] = {", wtab(level), i)
            if i == 1 then
                tprint("%s{    --%s[%d]", tab(level), tag, i)
            else
                tprint("%s}, { --%s[%d]", tab(level), tag, i)
            end

            read_tag(level+1, i)
        end
        -- close var
        tprint("%s}", tab(level+1))

        tprint("%s}", tab(level))
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


-- print internal dict (sorted by usage)
out:write("local L = {\n")

local t1 = {}   -- strings
local t2 = {}   -- translates
for k, v in pairs(dict_i) do
    if type(k) == "number" then -- skip name and size keys
        if v[3] == "L" then
            table.insert(t2, {k, v})
        else
            table.insert(t1, {k, v})
        end
    end
end
table.sort(t1, function (a, b) return (a[2][4] < b[2][4]) end)
table.sort(t2, function (a, b) return (a[2][4] < b[2][4]) end)

local fmt = "  [%d] = { %4d, %s },\n"
out:write("  size = " .. dict_i.size .. ",\n")

out:write("  -- <TRANSLATE>\n")
for _, v in ipairs(t2) do
    out:write(fmt:format(v[1], v[2][1], v[2][2]))
end

out:write("  -- <STRING>\n")
for _, v in ipairs(t1) do
    out:write(fmt:format(v[1], v[2][1], v[2][2]))
end

out:write("}\n")
out:write(("--------"):rep(10))
out:write("\n")


-- print content
out:write("-- n -> name, t -> type, v -> value\n")
out:write("local content = {\n")
out:write(table.concat(output, "\n"))
out:write("\n}\nreturn L, content\n")

if out_file then
    out:close()
end
