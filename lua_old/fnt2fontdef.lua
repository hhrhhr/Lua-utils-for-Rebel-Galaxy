assert("Lua 5.3" == _VERSION)

local in_file = assert(arg[1], "no input")
local font_name = arg[2] or "Verdana"
local font_file = arg[3] or "verdana.dds"
local v_offset = arg[4]

local r = assert(io.open(in_file))

local t = {}

-- first and second lines
for i = 1, 2 do
    local line = r:read("*l")
    for k, v in string.gmatch(line, "(%w+)=(%w+)") do
        t[k] = tonumber(v)
    end
end

-- page line
t.page = {}
for i = 1, t.pages do
    local tt = {}
    local line = r:read("*l")
    for k, v in string.gmatch(line, "(%w+)=(%w+)") do
        tt[k] = tonumber(v)
    end
    table.insert(t.page, tt)
end

-- char count
local line = r:read("*l")
for k, v in string.gmatch(line, "(%w+)=(%w+)") do
    t[k] = tonumber(v)
end

-- chars
t.char = {}
for i = 1, t.count do
    local tt = {}
    local line = r:read("*l")
    for k, v in string.gmatch(line, "(%a+)=([-%d]+)") do
        tt[k] = tonumber(v)
    end
    table.insert(t.char, tt)
end

r:close()

io.write(font_name .. "\n")

io.write([[
{
	type	image
	source	media/fonts/]])
io.write(font_file .. "\n")
io.write("	uoffset	0\n")


local w = t.scaleW
local h = t.scaleH

for k, v in ipairs(t.char) do
    local id = v.id --+ 32
    local vx = v.x
    local vy = v.y
    
    local x1 = vx / w
    local y1 = vy / h * 0.5
    local x2 = (vx + v.width) / w
    local y2 = (vy + v.height) / h * 0.5

    if v_offset then
        y1 = y1 + 0.5
        y2 = y2 + 0.5
    end

    local fmt = "\tglyph u%d %f %f %f %f\n"
    io.write(fmt:format(id, x1, y1, x2, y2))
end

io.write("}\n")
