local M = {}

function M.list_find(list, fn)
	for _, item in ipairs(list) do
		if fn(item) then
			return item
		end
	end
end

return M
