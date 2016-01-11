assert("Lua 5.3" == _VERSION)

local in_file = assert(arg[1], "no input")
local conflict_file = assert(arg[2], "no input")

local conflict = dofile(conflict_file)

for line in io.lines(in_file) do
    for i, s in string.gmatch(line, "(%d+), (.+)") do
        i = tonumber(i)
        local check = conflict[i]
        if check and check ~= s then
            print(("[%d] = %s"):format(i, check))
            print(("[%d] = %s"):format(i, s))
            print()
        end
    end
end
