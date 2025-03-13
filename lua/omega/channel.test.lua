local channel = require("omega.channel"):new({ "cat" })

channel:send("hello")

channel:read(function(value)
	assert(value == "hello")
end)

vim.schedule(function()
	channel:close()
end)
