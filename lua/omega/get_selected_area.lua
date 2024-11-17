local M = {}

function M.get_selected_area()
	local start_lnum, start_col = M._get_pos("v")
	local end_lnum, end_col = M._get_pos(".")

	if start_lnum > end_lnum then
		start_lnum, end_lnum = end_lnum, start_lnum
		start_col, end_col = end_col, start_col
	end

	if start_lnum == end_lnum and start_col > end_col then
		start_col, end_col = end_col, start_col
	end

	if vim.api.nvim_get_mode().mode == "V" then
		start_col = 1
		---@diagnostic disable-next-line: param-type-mismatch
		local end_line = vim.api.nvim_buf_get_lines(0, end_lnum - 1, end_lnum, false)[1]
		end_col = vim.fn.strdisplaywidth(end_line)
	end

	return { start_lnum = start_lnum, start_col = start_col, end_lnum = end_lnum, end_col = end_col }
end

---@param expr string
---@return number | nil, number | nil
function M._get_pos(expr)
	local res = vim.fn.getpos(expr)
	if not res then
		return nil
	end

	local lnum = res[2]
	local col = res[3]
	return lnum, col
end

return M
