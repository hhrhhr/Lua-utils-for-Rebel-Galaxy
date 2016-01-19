local hash_needed = tonumber(arg[1]) or 0
local start_value = arg[2] or "A"


local dict_str = "\x20!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}`"
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


local function show_str()
    local s = {}
    for i = 1, strlen do
        table.insert(s, string.char(dict[str[i]]))
    end
    -- print(table.concat(s))
    return (table.concat(s))
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
local t = {}

local function fix()
    for i = 1, strlen do
        local oldchar = str[i]
        for j = 1, diclen do
            str[i] = j
            --show_str()
            local h = hash(str)
            table.insert(t, {h, show_str()})
--[[
            if (h == hash_needed) then
                io.write(h)
                io.write(" ")
                show_str()
            end
--]]
        end
        str[i] = oldchar
    end
end

fix()

table.sort(t, function (a, b) return a[1] < b[1] end)

for i = 1, #t do print(t[i][1] .. ", " .. t[i][2]) end
