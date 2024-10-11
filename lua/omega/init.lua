---@class Omega
---@field dofile fun(file_path: string) dofile without cache
---@field root_pattern fun(...): string | nil search root directory
---@field exist fun(path: string): boolean check if path exists
---@field list_find fun(list: any[], fn: fun(item: any): boolean): any | nil find item in a list
---@field is_dir fun(path: string): boolean check if path is dir
---@field exist_in_file fun(text: string, path: string): boolean check if text exists in file

local fns = {
	"dofile",
	"root_pattern",
	"exist",
	"list_find",
	"is_dir",
	"exist_in_file",
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
