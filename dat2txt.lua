assert("Lua 5.3" == _VERSION)

local in_file = assert(arg[1], "no input")
local out_path = arg[2] or "."

local r
local function uint32() return string.unpack("<I", r:read(4)) end
local function sint32() return string.unpack("<i", r:read(4)) end
local function uint16() return string.unpack("<H", r:read(2)) end
local function uint8()  return string.unpack("B",  r:read(1)) end
local function float()  return string.unpack("f",  r:read(4)) end

local dict_t = {
    [1] = "INTEGER",
    [2] = "FLOAT",
    [5] = "STRING",
    [6] = "BOOL",
    [120] = "X",
    [121] = "Y",
    [745] = "UI",
    [6434245] = "FILE",
    [6688229] = "NAME",
    [252743109] = "SCALE",
    [257268424] = "WIDTH",
    [343250261] = "HEIGHT",
    [589835972] = "SPRITE",
    [741659033] = "CONTAINER",
    [1336946094] = "KEYBINDING",
    [4127570586] = "KEYBINDINGS",
}

local function dict(key)
    return dict_t[key] or ("$" .. key)
end

local function tab(level)
    io.write((" "):rep(4 * level))
end

local function read_var(level)
    local nam = uint32()
    local typ = uint32()
    local val
    if     typ == 1 then
        val = sint32()
    elseif typ == 2 then
        val = float()
    elseif typ == 5 then
        val = uint32()
        val = dict(val)
    elseif typ == 6 then
        val = uint32()
        val = (val == 0) and "false" or "true"

    elseif typ == 8 then    -- ???
        val = uint32()
        val = dict(val)

    else
        val = uint32()
    end

    nam = dict(nam)
    typ = dict(typ)
    tab(level)
    print("<".. typ ..">" .. nam .. ":" .. val)
end

local function read_tag(level)
    local tag = uint32()
    tag = dict(tag)
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

local count = uint32()
for i = 1, count do
    local idx = uint32()
    local len = uint16()
    local str = r:read(len)
    local d = dict_t[idx]
    if d ~= nil then
        if d ~= str then
            print("!!! COLLISION: dict[" .. idx .. "] = " .. d .. " <= " .. str)
        end
    end
    dict_t[idx] = str
end

read_tag(0)

r:close()
