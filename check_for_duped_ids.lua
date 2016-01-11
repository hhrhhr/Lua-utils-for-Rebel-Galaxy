assert("Lua 5.3" == _VERSION)

local in_file = assert(arg[1], "no input")
local lang_file = assert(arg[2], "no input")

local t, s = dofile(lang_file)

local prev_i = ""
local prev_s = ""
local dup = 0

local ori = "--  [%d] = %q,"
local fmt = "    [%d] = %q,"

print("local dupes = {")

for line in io.lines(in_file) do
    for i, s in string.gmatch(line, "(%d+), (.+)") do
        if prev_i == i and prev_s ~= s then
            if dup == 0 then
                print()
                dup = dup + 1
                local j = tonumber(i)
                local o = t[j] or s[j] or "!!! NOT FOUND !!!"
                print(ori:format(j, o))
                print(fmt:format(prev_i, prev_s))
            end
            dup = dup + 1
            print(fmt:format(i, s))
            prev_i = i
        else
            prev_i = i
            prev_s = s
            dup = 0
        end
    end
end

print("}\nreturn dupes")