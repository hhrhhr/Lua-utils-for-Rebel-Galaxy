assert("Lua 5.3" == _VERSION)
local zlib = require("lua_zlib")
local lfs = require("lua_lfs")

local in_path = arg[1] or "."
local out_file = arg[2] or "DATA2.PAK"

if in_path:sub(-1) ~= "\\" then
    in_path = in_path .. "\\"
end


local entries = 0
local dirs = 0
local offset = 14

local header = {}
local w

local function uint32(i) return string.pack("<I", i) end
local function uint16(i) return string.pack("<H", i) end
local function uint8(i)  return string.pack("B",  i) end


local function scan(path)
    local count = 0
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            count = count + 1
        end
    end

    local t = {}
    local idx = 0

    for file in lfs.dir(path) do
        if file == "." or file == ".." then
            goto next_file
        end

        idx = idx + 1
        entries = entries + 1

        local fullpath = path .. file
        local crc, typ, off, size, fname = 0, 8, 0, 0, ""

        local attr = lfs.attributes(fullpath)
        if attr.mode == "directory" then
            fname = file .. "/"

        else
            for t, f in file:gmatch("(%d+)_(.+)") do
                typ = t
                fname = f
            end

            -- read & pack
            local r = assert(io.open(fullpath, "rb"))
            local data = r:read("*a")
            r:close()

            crc = zlib.crc32()(data)
            local eof, zsize = false, 0
            data, eof, size, zsize = zlib.deflate()(data, "finish")
            off = offset
            offset = offset + zsize + 8

            -- add packed data
            w:write(uint32(size))
            w:write(uint32(zsize))
            w:write(data)
        end

        local itr = idx .. "\\" .. count
        print(("%9s %08X %2d %10d %8d %s"):format(itr, crc, typ, off, size, fname))
        t[idx] = {crc, typ, #fname, fname:gsub("(.)", "%1\x00"), off, size}

        ::next_file::
    end

    table.insert(header, t)
end


local function dir(path)
    for file in lfs.dir(path) do
        if file == "." or file == ".." then
            goto next_dir
        end

        local fullpath = path .. file
        local attr = lfs.attributes(fullpath)
        if attr.mode == "directory" then
            dirs = dirs + 1
            fullpath = fullpath .. "/"
            local fp = fullpath:gsub(in_path, "")

            print()
            print(dirs, fp)

            table.insert(header, {#fp, fp:gsub("(.)", "%1\x00")})

            scan(fullpath)

            dir(fullpath)
        end
        ::next_dir::
    end
end


--[[ main ]]--------------------------------------------------------------------

w = assert(io.open(out_file, "w+b"))

w:write(uint32(1))          -- header
w:write(uint16(0))
w:write(uint32(0))          -- filenames offset
w:write(uint32(16777344))   -- flags 0x01000080

-- packed files data
dir(in_path)


-- filenames data
local filenames_offset = w:seek()
w:write(uint32(entries))
w:write(uint32(dirs))

for k, v in ipairs(header) do
    if type(v[1]) == "number" then
        --print(table.concat(v, "\t"))
        w:write(uint16(v[1]))       -- #dirname
        w:write(v[2])               -- dirname (utf16le)
    else
        w:write(uint32(#v))         -- count
        for i, j in ipairs(v) do
            --print(table.concat(j, "\t"))
            w:write(uint32(j[1]))   -- crc
            w:write(uint8( j[2]))   -- typ
            w:write(uint16(j[3]))   -- len
            w:write(       j[4])    -- fname
            w:write(uint32(j[5]))   -- offset
            w:write(uint32(j[6]))   -- unpacked
        end
    end
end

w:close()

-- update
w = assert(io.open(out_file, "r+b"))

w:seek("set", 6)
w:write(uint32(filenames_offset))

w:close()