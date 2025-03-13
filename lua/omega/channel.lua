---@diagnostic disable: undefined-field
---@diagnostic disable: missing-fields

---@class omega.Channel
local Channel = {}

function Channel:new(cmd, opts)
	local instance

	local function on_output(_, data)
		if #instance.read_callbacks > 0 then
			vim.iter(instance.read_callbacks):each(function(callback)
				callback(data)
			end)
			instance.read_callbacks = {}
		else
			table.insert(instance.output, data)
		end
	end

	opts = opts or {}
	opts = vim.tbl_extend("force", opts, {
		stdin = true,
		stdout = on_output,
		stderr = on_output,
	})

	instance = {
		job = vim.system(cmd, opts, function(result)
			if result.code ~= 0 then
				error(result.stderr)
			end
		end),
		output = {},
		error = {},
		read_callbacks = {},
	}

	setmetatable(instance, {
		__index = Channel,
	})

	return instance
end

function Channel:send(data)
	self.job:write(data)
end

function Channel:read(callback)
	if #self.output > 0 then
		local output = vim.fn.join(self.output, "\n")
		self.output = {}
		callback(output)
	else
		table.insert(self.read_callbacks, callback)
	end
end

function Channel:close()
	if not self.job.is_closing() then
		self.job:kill(9)
	end
end

return Channel
