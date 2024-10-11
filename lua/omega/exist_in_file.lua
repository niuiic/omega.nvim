local M = {}

function M.exist_in_file(text, path)
	if not require("omega.exist").exist(path) then
		return false
	end

	if require("omega.is_dir").is_dir(path) then
		return false
	end

	local lines = vim.fn.readfile(path, "")
	local file = ""
	for _, line in ipairs(lines) do
		file = file .. "\n" .. line
	end
	file = string.sub(file, 2)

	return string.find(file, text, 1, true) ~= nil
end

return M
