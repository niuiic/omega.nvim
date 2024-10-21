local M = {}

function M.calc_text_edits(old_text, new_text)
	return require("omega-rs").calc_text_edits(old_text, new_text)
end

return M
