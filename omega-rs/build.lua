os.execute("cargo build --release")

local file = io.open("./target/release/libomega_rs.so")
if not file then
	return
end

local text = file:read("*a")
file:close()

file = io.open("../lua/omega_rs.so", "w+")
if not file then
	return
end
file:write(text)
file:close()
