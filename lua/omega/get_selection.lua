local M = {}

function M.get_selection()
	local mode = vim.api.nvim_get_mode().mode

	if mode == "n" then
		return { vim.fn.expand("<cexpr>") }
	end

	local ok, selection = pcall(function()
		return vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = mode })
	end)

	if ok then
		return selection
	end
end

return M
