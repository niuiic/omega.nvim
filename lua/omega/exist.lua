local M = {}

function M.exist(path)
	local target = io.open(path, "r")
	if target then
		io.close(target)
		return true
	end
	return false
end

return M
