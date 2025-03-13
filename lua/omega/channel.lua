---@diagnostic disable: undefined-field
---@diagnostic disable: missing-fields

---@class omega.Channel
local Channel = {}

function Channel:new(cmd, opts)
	local instance

	opts = opts or {}
	opts = vim.tbl_extend("force", opts, {
		stdin = true,
		stdout = function(_, data)
			table.insert(instance.output, data)

			if #instance.read_callbacks > 0 then
				vim.iter(instance.read_callbacks):each(function(callback)
					callback(data)
				end)
				instance.read_callbacks = {}
				instance.read_index = #instance.output
			end
		end,
	})

	instance = {
		job = vim.system(cmd, opts, function(result)
			if result.code ~= 0 then
				error(result.stderr)
			end
		end),
		output = {},
		read_index = 0,
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
	if #self.output > self.read_index then
		local output = table.concat(self.output, "\n", self.read_index + 1, #self.output)
		self.read_index = #self.output
		callback(output)
	else
		table.insert(self.read_callbacks, callback)
	end
end

function Channel:close()
	self.job:kill(9)
end

return Channel
