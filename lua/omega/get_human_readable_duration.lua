local M = {}

function M.get_human_readable_duration(start_time, end_time)
	return require("omega-rs.module").get_human_readable_duration(start_time, end_time)
end

return M
