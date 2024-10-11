local is_dir = require("omega.is_dir").is_dir
local root_pattern = require("omega.root_pattern").root_pattern

assert(is_dir(root_pattern(".git")))
assert(not is_dir(root_pattern(".git") .. "/.gitignore"))
assert(not is_dir(root_pattern(".git") .. "/xxx"))
