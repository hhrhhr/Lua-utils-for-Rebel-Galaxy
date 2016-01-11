assert("Lua 5.3" == _VERSION)

local in_file = assert(arg[1], "no input")


-- binary read
local r
local function sint64(v) return string.unpack("<i8", v or r:read(8)) end
local function uint32(v) return string.unpack("<I4", v or r:read(4)) end
local function sint32(v) return string.unpack("<i4", v or r:read(4)) end
local function uint16(v) return string.unpack("<H",  v or r:read(2)) end
local function uint8(v)  return string.unpack("B",   v or r:read(1)) end
local function float(v)  return string.unpack("f",   v or r:read(4)) end


-- dictionaries
local dict_i = {name = "internal"}  -- from current file
local dict = {}


local function prints(v, t)
    table.insert(dict, v .. ", " .. t .. ", " .. dict_i[v])
end


-- parse
local function read_var()
    local _   = uint32()    -- name
    local typ = uint32()
    local val               -- get below

    if     typ == 1 then    -- int
        val = sint32()
    elseif typ == 2 then    -- float
        val = float()
    elseif typ == 5 then    -- string from internal dict
        val = uint32()
        prints(val, "S")
    elseif typ == 6 then    -- bool
        val = uint32()
        val = (val == 0) and "false" or "true"
    elseif typ == 7 then    -- int64
        val = sint64()
    elseif typ == 8 then    -- localized string
        val = uint32()
        prints(val, "T")
    else
        assert(false, "\n!!! unknown typ " .. typ .. "\n\n")
    end

end


local function read_tag()
    local _ = uint32()  -- tag
    
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
    dict_i[idx] = str
end

-- start parse
read_tag(1, 1)

r:close()


-- get unique strings
table.sort(dict)

local old = ""
for k, v in ipairs(dict) do
    if old ~= v then
        print(v)
    end
    old = v
end
