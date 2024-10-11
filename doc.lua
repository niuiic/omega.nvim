local file = io.open("./lua/omega/init.lua")
if not file then
	return
end

local parse_line = function(line)
	local name, type, desc = string.match(line, [[---@field ([%S]+) (fun[^%[]+) %[(.*)%]] .. "]")
	if not name then
		return
	end

	return {
		name = name,
		type = type,
		desc = desc,
	}
end

local fns = {}

for line in file:lines() do
	local fn = parse_line(line)
	if fn then
		table.insert(fns, fn)
	end
end
file:close()

file = io.open("./README.md")
if not file then
	return
end

local fix_str = function(str)
	return string.gsub(str, "|", [[\|]])
end
local docs = {}
local skip_line = false
for line in file:lines() do
	if not skip_line and not string.find(line, "## Functions", 1, true) then
		table.insert(docs, line)
	elseif not skip_line then
		skip_line = true
		table.insert(docs, line)
		table.insert(docs, "")
		table.insert(docs, "name|type|desc")
		table.insert(docs, "-|-|-")
		for _, fn in ipairs(fns) do
			table.insert(docs, string.format("%s|%s|%s", fix_str(fn.name), fix_str(fn.type), fix_str(fn.desc)))
		end
		table.insert(docs, "")
	elseif skip_line and string.find(line, "## ") then
		skip_line = false
		table.insert(docs, line)
	end
end
file:close()

local text = ""
for _, line in ipairs(docs) do
	text = text .. "\n" .. line
end
text = string.sub(text, 2)

file = io.open("./README.md", "w")
if not file then
	return
end
file:write(text)
file:close()
