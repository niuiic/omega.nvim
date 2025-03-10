local M = {}

M.await = function(fn)
	return coroutine.yield(fn)
end

return M
