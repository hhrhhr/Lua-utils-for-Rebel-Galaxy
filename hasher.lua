local function hash(str)
    local res = #str
    for i = 1, res do
        local char = str:sub(i, i):byte()
        res = res << 0x05 & 0xFFFFFFFF ~ char ~ res >> 0x1B
    end
    return(res)
end

for i = 1, #arg do
    local str = arg[i]
    local res = hash(str)
    print(string.format("%d, \"%s\", --0x%08X", res, str, res))
end
