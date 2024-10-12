---@class Omega
---@field dofile fun(file_path: string) [dofile without cache]
---@field exist_in_file fun(text: string, path: string): boolean [check if text exists in file]
---@field get_selected_area fun(): omega.Area [get selected area]
---@field get_selection fun(): string[] | nil [get selected text, get cursor word in normal mode]
---@field to_normal_mode fun() [enter normal mode]

local fns = {
	"dofile",
	"exist_in_file",
	"get_selected_area",
	"get_selection",
	"to_normal_mode",
}

local function call(fn)
	return function(...)
		return require("omega." .. fn)[fn](...)
	end
end

---@type Omega
---@diagnostic disable-next-line: missing-fields
local M = {}
for _, fn in ipairs(fns) do
	M[fn] = call(fn)
end

return M
