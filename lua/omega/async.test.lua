local async = require("omega.async").async
local await = require("omega.await").await

local function async_fn(callback)
	vim.defer_fn(function()
		callback(100, true)
	end, 100)
end

async(function()
	local data1, data2 = await(async_fn)
	assert(data1, 100)
	assert(data2, true)
end)()
