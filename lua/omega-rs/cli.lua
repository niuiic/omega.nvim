local M = {}

---@return string
function M.get_cli()
	return debug.getinfo(1).source:match("@?(.*/)"):match("(.*)/[^/]+/[^/]+") .. "/rs/target/release/cli"
end

return M
