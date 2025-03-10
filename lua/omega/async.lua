local M = {}

M.async = function(fn)
	return function(...)
		local co = coroutine.create(fn)

		local function resume(...)
			local status, result = coroutine.resume(co, ...)

			if not status then
				error(result)
			end

			if coroutine.status(co) ~= "dead" then
				local async_fn = result
				async_fn(function(...)
					resume(...)
				end)
			end
		end
		resume(...)
	end
end

return M
