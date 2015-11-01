assert("Lua 5.3" == _VERSION)

local in_file = assert(arg[1], "no input")
local out_file = arg[2]


local out = io.stdout
if out_file then
    out = assert(io.open(out_file, "w+"))
end

local function tab(level)
    out:write((" "):rep(2 * level))
end

local L, content

local function read_tag(t, l)
    tab(l)
    out:write("[" .. t.n .. "]")
    out:write(" ; vars=" .. (t.vars and #t.vars or 0))
    out:write(" tags=" .. (t.tags and #t.tags or 0) .. "\n")

    if t.vars then
        for k, v in ipairs(t.vars) do
            local value = v.v
            if v.t == "TRANSLATE" then
                value = L[value][2]
            end
            
            tab(l+1)
            out:write("<"..v.t..">"..v.n..":"..tostring(value).."\n")
        end
    end

    if t.tags then
        for k, v in ipairs(t.tags) do
            read_tag(v, l+1)
        end
    end
    
    tab(l)
    out:write("[/" .. t.n .. "]\n")
end


L, content = dofile(in_file)
read_tag(content, 0)
