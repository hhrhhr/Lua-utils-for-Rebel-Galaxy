local dict = assert(arg[1], "\nno input\n\n")

local prev_l = ""
local prev_i = 0
local prev_t = ""
local prev_s = ""

for line in io.lines(dict) do
    
    for i, t, s in string.gmatch(line, "(%d+), ([ST]), (.+)") do
        if prev_i == i then
            if prev_t ~= t then
                print(i, s)
            else
                prev_t = t
            end
        else
            prev_i = i
        end
    end
    prev_l = line
end

