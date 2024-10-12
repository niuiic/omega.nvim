package.path = package.path .. ";./lua/?.lua;./lua/?/init.lua"

for file_name in io.popen("ls ./lua/omega"):lines() do
	if string.find(file_name, ".test.", 1, true) then
		dofile("./lua/omega/" .. file_name)
	end
end
