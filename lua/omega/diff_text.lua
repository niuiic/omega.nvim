local M = {}

function M.diff_text(old_text, new_text, callback)
	xpcall(
		require("omega-rs.cli").call,
		function()
			callback(M._get_full_text_edits(old_text, new_text))
		end,
		{ "diff", "--old-text", string.format('"%s"', old_text), "--new-text", string.format('"%s"', new_text) },
		nil,
		function(result)
			if result.code == 0 and result.stdout ~= "" then
				local ok, text_edits = pcall(vim.json.decode, result.stdout)
				if not ok then
					text_edits = M._get_full_text_edits(old_text, new_text)
				end

				callback(text_edits)
			else
				callback({})
			end
		end
	)
end

function M._get_full_text_edits(old_text, new_text)
	local old_lines = vim.fn.split(old_text, require("omega").get_line_ending(0))
	local last_old_line_chars = require("omega").get_chars(old_lines[#old_lines])

	local text_edits = {
		{
			range = {
				start = {
					line = 0,
					character = 0,
				},
				["end"] = {
					line = #old_lines - 1,
					character = #last_old_line_chars,
				},
			},
			newText = new_text,
		},
	}

	return text_edits
end

return M
