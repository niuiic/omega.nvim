-- % root_pattern %
local root_pattern = require("omega.root_pattern").root_pattern

local root_dir = (string.match(vim.api.nvim_buf_get_name(0), "(.+)/lua/omega/.+"))
assert(root_pattern(".git") == root_dir)
assert(root_pattern(".tig", ".git") == root_dir)
assert(root_pattern(".tig") == nil)

-- % _get_parent_dir %
local _get_parent_dir = require("omega.root_pattern")._get_parent_dir

assert(_get_parent_dir("/x/") == "/")
assert(_get_parent_dir("/x") == "/")
assert(_get_parent_dir("/") == nil)
assert(_get_parent_dir("") == nil)
