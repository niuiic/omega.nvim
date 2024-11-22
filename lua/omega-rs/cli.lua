local M = {}

---@param cmd string[]
---@param opts vim.SystemOpts | nil
---@param on_exit fun(out: vim.SystemCompleted) | nil
---@return vim.SystemObj
function M.call(cmd, opts, on_exit)
	return vim.system(
		vim.list_extend({
			debug.getinfo(1).source:match("@?(.*/)"):match("(.*)/[^/]+/[^/]+") .. "/rs/target/release/cli",
		}, cmd),
		opts,
		on_exit
	)
end

return M
