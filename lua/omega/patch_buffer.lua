local M = {}

function M.patch_buffer()
	require("omega-rs").diff_text("", "", function(str)
		print("[1] QUICK_PRINT(lua/omega/patch_buffer.lua:4) str = ", vim.inspect(str))
	end)
end

print(M.patch_buffer())

return M
