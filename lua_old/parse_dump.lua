local dump = assert(arg[1], "\nno input\n\n")


local pattern = "([%u][%u%d_]+)$"
--local pattern = "ASCII \"([%u%d_]+)\""
--local pattern = "ASCII \"([^\\\"]+)\"$"


local function hash(str)
    local res = #str
    for i = 1, res do
        local char = str:sub(i, i):byte()
        res = res << 0x05 & 0xFFFFFFFF ~ char ~ res >> 0x1B
    end
    return(res)
end

--------------------------------------------------------------------------------
local str = {}
for line in io.lines(dump) do
    for s in string.gmatch(line, pattern) do
        if s then
            if #s == #line then
                table.insert(str, s)
            end
        end
    end
end

table.sort(str)

local hash_str = {}

local prev = ""
for i = 1, #str do
    local next = rawget(str, i)
    if next ~= prev then
        table.insert(hash_str, {hash(next), next})
        --print(hash(next) .. ", \"" .. next .. "\",")
        prev = next
    end
end
str = nil

table.sort(hash_str, function(a, b) return a[1] < b[1] end)

for i = 1, #hash_str do
    print(hash_str[i][1] .. ", \"" .. hash_str[i][2] .. "\",")
end
