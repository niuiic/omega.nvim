local M = {}

function M.root_pattern(...)
	local patterns = { ... }
	---@type string | nil
	local dir = M._normalize_path(vim.fn.getcwd(-1, -1))

	while dir do
		for _, pattern in ipairs(patterns) do
			if M._is_dir_match_pattern(dir, pattern) then
				return dir
			end
		end
		dir = M._get_parent_dir(dir)
	end
end

function M._get_parent_dir(dir)
	dir = M._normalize_path(dir)

	local parent_dir = string.match(dir, "(.*)/[^/]+")
	if parent_dir == nil then
		return nil
	elseif parent_dir == "" then
		return "/"
	else
		return parent_dir
	end
end

function M._normalize_path(dir)
	if string.sub(dir, string.len(dir)) == "/" then
		return string.sub(dir, 1, string.len(dir) - 1)
	else
		return dir
	end
end

function M._is_dir_match_pattern(dir, pattern)
	return require("omega.exist").exist(dir .. "/" .. pattern)
end

return M
