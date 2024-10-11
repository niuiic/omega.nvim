local M = {}

function M.get_selection()
	local mode = vim.api.nvim_get_mode().mode
	local area = require("omega.get_selected_area").get_selected_area()

	if mode == "v" or mode == "V" then
		local lines = vim.api.nvim_buf_get_lines(0, area.start_lnum - 1, area.end_lnum, false)
		lines[1] = string.sub(lines[1], area.start_col - 1)
		lines[#lines] = string.sub(lines[#lines], 1, area.end_col)

		local selection = ""
		for _, line in ipairs(lines) do
			selection = selection .. "\n" .. line
		end
		return string.sub(selection, 2)
	end
end

return M
