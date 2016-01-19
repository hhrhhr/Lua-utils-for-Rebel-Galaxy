local in_file = assert(arg[1], "\nno input\n\n")
local shared = arg[2]


-- load file (must be sorted and deduped)
local dict_uniq = {}
for line in io.lines(in_file) do
    for i, t, s in string.gmatch(line, "(%d+), ([ST]), (.+)") do
        table.insert(dict_uniq, {tonumber(i), t, s})
    end
end

-- sort by idx then type
function sort_by_id_type(a, b)
    if a[1] < b[1] then
        return true
    elseif a[1] > b[1] then
        return false
    else
        if a[2] < b[2] then
            return true
        else
            return false
        end
    end
end
table.sort(dict_uniq, sort_by_id_type)


-- start output

local lang = {}
for _, v in ipairs(dict_uniq) do
    local i = v[1]  -- idx
    local t = v[2]  -- "T" or "S"
    local s = v[3]  -- string
    local l = lang[i]

    if l then
        if l[1] and t == "S" then
            l[1] = t
        end
        assert(l[2] == s, "\n\n" .. l[2] .. " ~= " .. s .. "\n\n")
    else
        lang[i] = {t, s}
    end
end
dict_uniq = nil

local t = {}    -- TRANSLATE
local s = {}    -- STRING

if shared then
    for i = 1, 2^15 do
        if not lang[i] then
            lang[i] = {"X", "nil"}
        end
    end
end

for k, v in pairs(lang) do
    if shared == nil then
        if v[1] == "T" then
            table.insert(t, k)
        else
            table.insert(s, k)
        end
    else
        table.insert(s, k)
    end
end
table.sort(t)
table.sort(s)

if shared then 

    local fmt = "    [%d] = {%s, %s},"
    for i = 1, #s do
        local idx = s[i]
        print(fmt:format(idx, lang[idx][1], lang[idx][2]))
    end

else

    local fmt = "    [%d] = %s,"
    print("local translate = {")
    for i = 1, #t do
        local idx = t[i]
        print(fmt:format(idx, lang[idx][2]))
    end
    print("}\nlocal strings = {")
    for i = 1, #s do
        local idx = s[i]
        print(fmt:format(idx, lang[idx][2]))
    end
    print("}\n")
    print("return translate, strings\n")

end
