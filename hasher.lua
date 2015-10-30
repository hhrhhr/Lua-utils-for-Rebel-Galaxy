local str = arg[1] or "test"

local function hash(str)
    local res = #str
    for i = 1, res do
        local char = str:sub(i, i):byte()
        res = res << 0x05 & 0xFFFFFFFF ~ char ~ res >> 0x1B
    end
    return(res)
end

local res = hash(str)

print(string.format("0x%08X %10d '%s'", res, res, str))
