local M = {}

function M.spawn(cmd, args, on_exit, cwd, env)
	local stdout = vim.uv.new_pipe()
	local stderr = vim.uv.new_pipe()
	local ok = true
	local output
	local err

	vim.uv.read_start(stdout, function(_, data)
		output = output == nil and data or output .. data
	end)
	vim.uv.read_start(stderr, function(_, data)
		ok = false
		err = err == nil and data or err .. data
	end)

	return vim.uv.spawn(cmd, {
		stdio = { nil, stdout, stderr },
		args = args,
		env = env,
		cwd = cwd,
	}, function()
		if on_exit then
			on_exit(ok, output, err)
		end
	end)
end

return M
