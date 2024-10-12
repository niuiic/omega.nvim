-- % root_pattern %
local root_pattern = require("omega.root_pattern").root_pattern

local root_dir = (os.getenv("PWD"))
assert(root_pattern(".git") == root_dir)
assert(root_pattern(".tig", ".git") == root_dir)
assert(root_pattern(".tig") == nil)

-- % _get_parent_dir %
local _get_parent_dir = require("omega.root_pattern")._get_parent_dir

assert(_get_parent_dir("/x/") == "/")
assert(_get_parent_dir("/x") == "/")
assert(_get_parent_dir("/") == nil)
assert(_get_parent_dir("") == nil)
