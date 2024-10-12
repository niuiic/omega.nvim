local M = {}

function M.exist_in_file(text, path)
	if not vim.uv.fs_stat(path) then
		return false
	end

	if vim.fn.isdirectory(path) then
		return false
	end

	local lines = vim.fn.readfile(path, "")
	local file = vim.iter(lines):join("\n")

	return string.find(file, text, 1, true) ~= nil
end

return M
