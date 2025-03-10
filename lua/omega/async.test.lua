local async = require("omega.async").async
local await = require("omega.async").await

local function async_fn(callback)
	vim.defer_fn(function()
		callback(100)
	end, 100)
end

async(function()
	local result = await(async_fn)
	assert(result == 100)
end)
