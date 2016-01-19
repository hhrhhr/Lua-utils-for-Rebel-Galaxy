local in_file = assert(arg[1], "\nno input\n\n")
local search_type = assert(arg[2], "\nno search type\n\n")


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

local prev_l = ""   -- line
local prev_i = 0    -- idx
local prev_t = ""   -- type
local prev_s = ""   -- string
local dup = 0

local fmt = "    [%d] = %s,"

if search_type == "duplicate" then

    print("local duplicate = {")
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
    print("}\nreturn duplicate")

elseif search_type == "conflict" then

    print("local conflict = {")
    for _, v in ipairs(dict_uniq) do
        if prev_i == v[1] then
            if prev_t ~= v[2] then
                print(fmt:format(v[1], v[3]))
            else
                prev_t = v[2]
            end
        else
            prev_i = v[1]
        end
    end
    print("}\nreturn conflict")

else
    --assert("\nunknown search type\n\n")
end
