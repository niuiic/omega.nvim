local function call(fn)
	return function(...)
		require("omega." .. fn)[fn](...)
	end
end

local fns = {
	"root_pattern",
	"dofile",
	"exist",
}

---@type Omega
---@diagnostic disable-next-line: missing-fields
local M = {}
for _, fn in ipairs(fns) do
	M[fn] = call(fn)
end

return M
