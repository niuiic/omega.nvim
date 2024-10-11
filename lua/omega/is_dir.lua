local M = {}

function M.is_dir(path)
	local stat = vim.uv.fs_stat(path)
	return (stat and stat.type == "directory")
end

return M
