local M = {}

function M.diff_text(old_text, new_text, callback)
	require("omega-rs.cli").call({ "diff", "--old-text", old_text, "--new-text", new_text }, nil, function(result)
		if result.code == 0 then
			local text_edits = vim.json.decode(result.stdout)
			vim.schedule(function()
				callback(text_edits)
			end)
		end
	end)
end

return M
