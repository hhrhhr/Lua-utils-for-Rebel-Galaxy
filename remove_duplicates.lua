local in_file = assert(arg[1], "\nno input\n\n")


-- load file
local dict = {}
for line in io.lines(in_file) do
    table.insert(dict, line)
end

-- sort
table.sort(dict)

-- remove duplicates
local dict_uniq = {}
local prel_l = ""
for _, line in ipairs(dict) do
    if prev_l ~= line then
        table.insert(dict_uniq, line)
        prev_l = line
    end
end
dict = nil

-- start output
for _, v in ipairs(dict_uniq) do
    print(v)
end
