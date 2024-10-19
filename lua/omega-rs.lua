local function get_lib_extension()
	if jit.os:lower() == "mac" or jit.os:lower() == "osx" then
		return ".dylib"
	end
	if jit.os:lower() == "windows" then
		return ".dll"
	end
	return ".so"
end

package.cpath = package.cpath
	.. ";"
	.. debug.getinfo(1).source:match("@?(.*/)")
	.. "../omega-rs/target/release/lib?"
	.. get_lib_extension()
	.. ";"
	.. debug.getinfo(1).source:match("@?(.*/)")
	.. "../omega-rs/target/release/?"
	.. get_lib_extension()

return require("omega_rs")
