local exist_in_file = require("omega.exist_in_file").exist_in_file

assert(exist_in_file(".nvim", vim.fs.root(0, ".git") .. "/.gitignore"))
assert(not exist_in_file(".nvim", vim.fs.root(0, ".git") .. "/.xxx"))
assert(not exist_in_file(".nvim", vim.fs.root(0, ".git")))
