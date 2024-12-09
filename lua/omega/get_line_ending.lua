local M = {}

M.get_line_ending = function(bufnr)
	local format_line_ending = {
		["unix"] = "\n",
		["dos"] = "\r\n",
		["mac"] = "\r",
	}

	local line_ending = format_line_ending[vim.api.nvim_get_option_value("fileformat", {
		buf = bufnr,
	})] or "\n"

	return line_ending
end

return M
