local M = {}

function M.dofile(file_path)
	M._record_deps()
	dofile(file_path)
	M._reset_deps()
end

function M._record_deps()
	for key, value in pairs(package.loaded) do
		M._deps[key] = value
	end
end

function M._reset_deps()
	for key, _ in pairs(package.loaded) do
		if not M._deps[key] then
			package.loaded[key] = nil
		end
	end
	M._deps = {}
end

M._deps = {}

return M
