local t, s = dofile(arg[1])

local w, h = 256, 128
local b = 4
local b_c = "128 "
local z_c = "0 "
local t_c = "255 "

io.write("P2\n")
io.write(b * 2 + w .. " ")
io.write(b * 2 + h .. "\n")
io.write("255\n")

local max = w * h
local b_h = (b * 2 + w) * (b)

for i = 1, b_h do
    io.write(b_c)
end


local i = 0
for y = 1, h do
    for x = -b, w+b-1 do
        if x < 0 or x >= w then
            io.write(b_c)
        else
            if i < 2^15 then
                i = i + 1
                if t[i] or s[i] then
                    io.write(t_c)
                else
                    io.write(z_c)
                end
            end
        end
    end
    print()
end

for i = 1, b_h do
    io.write(b_c)
end

print()
