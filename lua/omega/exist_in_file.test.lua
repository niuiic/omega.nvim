local exist_in_file = require("omega.exist_in_file").exist_in_file
local root_pattern = require("omega.root_pattern").root_pattern

assert(exist_in_file(".nvim", root_pattern(".git") .. "/.gitignore"))
assert(not exist_in_file(".nvim", root_pattern(".git") .. "/.xxx"))
assert(not exist_in_file(".nvim", root_pattern(".git")))
