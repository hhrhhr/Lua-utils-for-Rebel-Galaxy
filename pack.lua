assert("Lua 5.3" == _VERSION)
local zlib = require("zlib")


local in_path = arg[1] or "."


local w = assert(io.open("DATA2.PAK", "wb"))

-- header
w:write(string.pack("<I", 1))
w:write(string.pack("<H", 0))

-- filenames offset
w:write(string.pack("<I", 0))

-- flags
w:write("\x80\x00\x00\x01")

local filedata_offset = w:seek()
print(filedata_offset)

-- file data
local files = {
    [1] = {
        name = "MEDIA\\UI\\MAINMENU.DAT",
    }
}

for i = 1, #files do
    local r = assert(io.open(in_path .. "\\" .. files[i].name, "rb"))
    files[i].size = r:seek("end")
    r:seek("set")
    local data = r:read("*a")
    files[i].crc = zlib.crc32()(data)

    local stream = zlib.deflate()
    local eof, bytes_in, bytes_out
    data, eof, bytes_in, bytes_out = stream(data, "finish")
    print("!!!", eof, bytes_in, bytes_out)

    w:write(string.pack("<I", bytes_in))
    w:write(string.pack("<I", bytes_out))
    w:write(data)
    r:close()
end

-- hack
w:write(("\x00"):rep(65536))

-- filename data
local filename_offset = w:seek()
print(filename_offset)

local entries = 2
local count = 2
w:write(string.pack("<I", entries))
w:write(string.pack("<I", count))


local name = "MEDIA\\"
w:write(string.pack("<H", #name))
name = string.gsub(name, "(.)", "%1\x00")
w:write(name)


count = 1
w:write(string.pack("<I", count))

name = "UI\\"
w:write(string.pack("<I", 0))   -- crc
w:write(string.pack("b", 8))    -- typ
w:write(string.pack("<H", #name))
name = string.gsub(name, "(.)", "%1\x00")
w:write(name)
w:write(string.pack("<I", 0))    -- off
w:write(string.pack("<I", 0))    -- unp


name = "MEDIA\\UI\\"
w:write(string.pack("<H", #name))
name = string.gsub(name, "(.)", "%1\x00")
w:write(name)


count = 1
w:write(string.pack("<I", count))

name = "MAINMENU.DAT"
w:write(string.pack("<I", files[1].crc))    -- 0x9C1EE66B
w:write(string.pack("b", 15))   -- typ
w:write(string.pack("<H", #name))
name = string.gsub(name, "(.)", "%1\x00")
w:write(name)
w:write(string.pack("<I", filedata_offset))     -- off
w:write(string.pack("<I", files[1].size))    -- unp 45360

w:close()


local w = assert(io.open("DATA2.PAK", "r+b"))
w:seek("set", 6)
w:write(string.pack("<I", filename_offset))
w:close()
