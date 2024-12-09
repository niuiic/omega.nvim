local M = {}

M.get_offset_encoding = function()
	local clients = vim.lsp.get_clients()
	local target = vim.iter(clients):find(function(client)
		return client.offset_encoding
	end)
	if target then
		return target.offset_encoding
	end
	return "utf-16"
end

return M
