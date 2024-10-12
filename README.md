# omega.nvim

Lua development utilities for Neovim.

All functions are lazy load.

[More neovim plugins](https://github.com/niuiic/awesome-neovim-plugins)

## Dev

Run current lua file with `require("omega").dofile(vim.api.nvim_buf_get_name(0))`. This function would unload deps of the file before running it, thus you can check the real-time update of the file without restart neovim.

It's recommended to do unit test with this function and builtin `assert`. Check `lua/omega/exist.test.lua` for an example.

## Functions

## Useful Neovim Builtin Functions

| name               | usage                        |
| ------------------ | ---------------------------- |
| vim.fn.isdirectory | check if path is a directory |
| vim.uv.fs_stat     | check if path exist          |
| vim.fs.root        | find root directory          |
| vim.system         | spawn a command              |
| vim.iter           | lua list operation           |
| vim.fs.joinpath    | concat path                  |
