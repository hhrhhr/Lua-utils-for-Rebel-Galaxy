assert("Lua 5.3" == _VERSION)
local zlib = require("lua_zlib")
local lfs = require("lua_lfs")


local in_file = assert(arg[1], "no input")
local out_path = arg[2] or "debug"

local function fromutf16le(str)
    local s = string.gsub(str, "(.)\x00", "%1")
    return s
end

local function mkdir(name)
    local fullname = out_path .. "\\" .. name
    local ok, msg = lfs.mkdir(fullname)
    if true ~= ok and "File exists" ~= msg then
        assert(false, msg)
    end
end

local r
local function uint32() return string.unpack("<I", r:read(4)) end
local function uint16() return string.unpack("<H", r:read(2)) end
local function uint8()  return string.unpack("B",  r:read(1)) end

local function savefile(offset, fullname)
    r:seek("set", offset)
    local size = uint32()
    local zsize = uint32()
    local data = r:read(zsize)

    local stream = zlib.inflate()
    local eof, bytes_in, bytes_out
    data, eof, bytes_in, bytes_out = stream(data)
    assert(true == eof, "eof ~= true")
    assert(zsize == bytes_in, "bytes_in mismatch")
    assert(size == bytes_out, "bytes_out mismatch")

    local w = assert(io.open(fullname, "w+b"))
    w:write(data)
    w:close()
end

--[[ main ]]--------------------------------------------------------------------

r = assert(io.open(in_file, "rb"))
local r_size = r:seek("end")
assert(-1 ~= r_size, "this Lua doesn't support files larger than 2 Gb")
r:seek("set")

local tmp
tmp = uint32()    -- \x01\x00\x00\x00
tmp = uint16()    -- \x00\x00

local filename_offset = uint32()
local flags = uint32()    -- \x80\x00\x00\x01

r:seek("set", filename_offset)
local entries = uint32()
local count = uint32()

if "debug" == out_path then
    print(entries, count)
end

for i = 1, count do
    local len = uint16()
    local name = r:read(len * 2)

    local current_dir = fromutf16le(name):gsub("/", "\\")
    if "debug" == out_path then
        print()
        print(i .. "/" .. count, current_dir)
    else
        mkdir(current_dir)
    end

    local count = uint32()
    for j = 1, count do
        local _crc = ("%08X"):format(uint32())
        local typ = uint8()
        local len = uint16()
        local name = r:read(len * 2)
        local offset = uint32()
        local _unp = uint32()

        local fn = fromutf16le(name)
        fn = fn:gsub("/", "\\")

        if "debug" == out_path then
            local out = "%9s %s %2d %10d %8d %s"
            print(out:format(j .. "/" .. count, _crc, typ, offset, _unp, fn))
        else
            local fullname = current_dir .. fn
            if 8 == typ then
                print("[" .. fullname .. "]")
                mkdir(fullname)
            else
                print(fullname)
                local save_pos = r:seek()
                fullname = out_path .. "\\" .. current_dir .. typ .. "_" .. fn
                savefile(offset, fullname)
                r:seek("set", save_pos)
            end
        end

        entries = entries - 1
    end
end

if entries > 0 then
    print("!!! left entries: " .. entries)
end

local left = r_size - r:seek()
if left > 0 then
    print("!!! left unreaded: " .. left)
end

r:close()
