local exist = require("omega.exist").exist
local root_pattern = require("omega.root_pattern").root_pattern

local root_dir = root_pattern(".git")
assert(exist(root_dir))
assert(exist(root_dir .. "/.gitignore"))
assert(not exist(root_dir .. "/xxx"))
