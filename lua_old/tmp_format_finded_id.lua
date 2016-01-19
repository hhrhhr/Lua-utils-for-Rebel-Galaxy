assert("Lua 5.3" == _VERSION)

local t = {}

for line in io.lines(arg[1]) do
    local s = string.gsub(line, "(.+):%s+{(.+)", "{%2\t%1")
    table.insert(t, s)
end

table.sort(t)

for i = 1, #t do print(t[i]) end

