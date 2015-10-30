local hash_needed = tonumber(arg[1]) or 0
local start_value = arg[2] or "A"
local depth = tonumber(arg[3]) or 1

local dict_str = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_"
--local dict_str = "ABCD"
local diclen = #dict_str
local dict = {}
for i = 1, #dict_str do
    table.insert(dict, dict_str:sub(i, i):byte())
end

local strlen = #start_value
local str = {}
for i = 1, strlen do
    local s = start_value:sub(i, i)
    for j = 1, diclen do
        if s == dict_str:sub(j, j) then
            str[i] = j
            break
        end
    end
end
for i = 1, depth do
    table.insert(str, 1)
end
strlen = strlen + depth
--print(table.concat(str, ":"))


local function show_str()
    local s = {}
    for i = 1, strlen do
        table.insert(s, string.char(dict[str[i]]))
    end
    print(table.concat(s))
end
--show_str()


local function hash(s)
    local res = #s
    for i = 1, res do
        local byte = rawget(dict, rawget(s, i))
        res = res << 0x05 & 0xFFFFFFFF ~ byte ~ res >> 0x1B
    end
    return res
end


--[[ start brute ]]-------------------------------------------------------------
local found = 0

local function brute(l)
    for i = 1, diclen do
        str[l] = i
        if (strlen - l + 1) < depth then
            brute(l-1)
        else
            --show_str()
            local h = hash(str)
            if (h == hash_needed) then
                found = found + 1
                io.write(h)
                io.write(" ")
                show_str()
            end
        end
    end
end

brute(strlen)

if found == 0 then
    print("brute unsuccesfull :(")
else
    print("keys founded: " .. found)
end

