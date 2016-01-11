assert("Lua 5.3" == _VERSION)

local in_file = assert(arg[1], "no input")

-- generate internal dictionary
local LS = {}   -- [idx]=key
local L, content = dofile(in_file)

for k, v in pairs(L) do
    if type(k) == "number" then
        LS[v[1]] = k
    end
end

-- check
assert(L.size == #LS)

for i = 1, #LS do
    local idx = LS[i]
    local str = L[idx][2]
    print(idx .. ", " .. str)
end
