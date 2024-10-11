local M = {}

function M.dofile(file_path)
	M._reload_deps(file_path)
	dofile(file_path)
end

function M._reload_deps(file_path)
	local lines = vim.fn.readfile(file_path, "")
	for _, line in ipairs(lines) do
		for dep in string.gmatch(line, [[require%("(.*)"%)]]) do
			package.loaded[dep] = nil
		end
	end
end

return M
