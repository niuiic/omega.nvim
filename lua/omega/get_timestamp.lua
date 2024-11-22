local M = {}

M.get_timestamp = function(time)
	return require("omega-rs.module").get_timestamp(time)
end

return M
