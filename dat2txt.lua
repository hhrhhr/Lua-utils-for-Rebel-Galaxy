assert("Lua 5.3" == _VERSION)

local in_file = assert(arg[1], "no input")
local out_path = arg[2] or "."

local r
local function uint32() return string.unpack("<I", r:read(4)) end
local function sint32() return string.unpack("<i", r:read(4)) end
local function uint16() return string.unpack("<H", r:read(2)) end
local function uint8()  return string.unpack("B",  r:read(1)) end
local function float()  return string.unpack("f",  r:read(4)) end

-- dictionaries
local dict_i = {name = "internal"}  -- from current file
local dict_e = {name = "external"}  -- from dict_ext
local dict_t = {name = "types"}     -- from dict_type
local dict_miss = {}                -- TODO: collect all missed keys

local function dict(t, key)
    local k = t[key]
    if k == nil then
        if not dict_miss[key] then
            dict_miss[key] = 1
            io.stderr:write("!!! unknown " .. t.name .. " key $" .. key .. "\n")
        end
        k = "$" .. key
    end
    return k
end


local function tab(level)
    io.write((" "):rep(2 * level))
end

local function read_var(level)
    local nam = uint32()
    local typ = uint32()
    local val
    if     typ == 1 then    -- int
        val = sint32()
    elseif typ == 2 then    -- float
        val = float()
    elseif typ == 5 then    -- string from dict
        val = uint32()
        val = dict(dict_e, val)
    elseif typ == 6 then    -- bool
        val = uint32()
        val = (val == 0) and "false" or "true"

    elseif typ == 8 then    -- localized string???
        val = uint32()
        val = dict(dict_e, val)

    else
        val = uint32()
        io.stderr:write("unknown typ " .. typ)
    end

    nam = dict(dict_e, nam)
    typ = dict(dict_t, typ)
    tab(level)

    print("<".. typ ..">" .. nam .. ":" .. val)
end

local function read_tag(level)
    local tag = uint32()
    tag = dict(dict_e, tag)
    tab(level)
    print("[" .. tag .. "]")
    level = level + 1

    -- var
    local num_vars = uint32()
    for i = 1, num_vars do
        read_var(level)
    end
    
    -- sect
    local num_tags = uint32()
    for i = 1, num_tags do
        read_tag(level)
    end

    level = level - 1
    tab(level)
    print("[/" .. tag .. "]")
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
local d = dofile("dict_ext.lua")
for i = 1, #d, 2 do
    dict_e[d[i]] = d[i+1]
end

-- generate internal dictionary
local count = uint32()
print("local dict_i = {")
for i = 1, count do
    local idx = uint32()
    local len = uint16()
    local str = r:read(len)
    local d = dict_e[idx]
    if d ~= nil then
        if d ~= str then
            io.stderr:write("!!! COLLISION: idx=" .. idx .. ", old=" .. d .. ", new=" .. str)
        end
    end
    dict_e[idx] = str
    print("    [" .. idx .. "] = '" .. str .. "',")
end
print("}")
print(("-"):rep(80))

read_tag(0)

r:close()
