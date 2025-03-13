local M = {}

function M.diff_text(old_text, new_text, callback)
	local ok, channel = pcall(function()
		return require("omega.channel"):new({ require("omega-rs.cli").get_cli(), "diff" })
	end)
	if not ok then
		callback({})
		return
	end

	channel:send(vim.json.encode({
		old_text = old_text,
		new_text = new_text,
	}))
	channel:send(nil)

	channel:read(function(data)
		local text_edits
		ok, text_edits = pcall(vim.json.decode, data)
		if not ok then
			text_edits = M._get_full_text_edits(old_text, new_text)
		end

		callback(text_edits)
	end)
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
