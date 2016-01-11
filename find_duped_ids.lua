local in_file = assert(arg[1], "\nno input\n\n")


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

local prev_l = ""
local prev_i = 0
local prev_t = ""
local prev_s = ""
local dup = 0

local fmt = "    [%d] = %s,"

print("local dupes = {")

for _, v in ipairs(dict_uniq) do
    if prev_i == v[1] and prev_s ~= v[3] then
        if dup == 0 then
            print()
            dup = dup + 1
            print(fmt:format(prev_i, prev_s))
        end
        dup = dup + 1
        print(fmt:format(v[1], v[3]))

        prev_i = v[1]
    else
        prev_i = v[1]
        prev_t = v[2]
        prev_s = v[3]
        dup = 0
    end
end

print("}\nreturn dupes")
