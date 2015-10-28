assert("Lua 5.3" == _VERSION)

local in_file = assert(arg[1], "no input")
local out_path = arg[2] or "."

local r
local function uint32() return string.unpack("<I", r:read(4)) end
local function sint32() return string.unpack("<i", r:read(4)) end
local function uint16() return string.unpack("<H", r:read(2)) end
local function uint8()  return string.unpack("B",  r:read(1)) end
local function float()  return string.unpack("f",  r:read(4)) end

-- dictionary
local dict_i = {}
local dict_e = {}
local function dict_int(key)
    return dict_i[key] or ("$" .. key)
end
local function dict_ext(key)
    local k = dict_e[key]
    return k and ("$" .. key .. ":" .. k) or ("$" .. key .. ":")
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
        val = dict_ext(val)
    elseif typ == 6 then    -- bool
        val = uint32()
        val = (val == 0) and "false" or "true"

    elseif typ == 8 then    -- localized string???
        val = uint32()
        val = dict_ext(val)

    else
        val = uint32()
    end

    nam = dict_int(nam)
    typ = dict_int(typ)
    tab(level)
    print("<".. typ ..">" .. nam .. ":" .. val)
end

local function read_tag(level)
    local tag = uint32()
    tag = dict_int(tag)
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

-- generate internal dictionary
local d = dofile("dict.lua")
for i = 1, #d, 2 do
    dict_i[d[i]] = d[i+1]
end

-- generate external dictionary
local count = uint32()
print("local dict_ext = {")
for i = 1, count do
    local idx = uint32()
    local len = uint16()
    local str = r:read(len)
    local d = dict_e[idx]
    if d ~= nil then
        if d ~= str then
            print("!!! COLLISION: dict[" .. idx .. "] = " .. d .. ", but => " .. str)
        end
    end
    dict_e[idx] = str
    print("    [" .. idx .. "] = '" .. str .. "',")
end
print("}")
print(("-"):rep(80))

read_tag(0)

r:close()
