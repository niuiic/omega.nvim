# omega.nvim

Lua development utilities for Neovim.

All functions are lazy load.

## Dev

Run current lua file with `require("omega").dofile(vim.api.nvim_buf_get_name(0))`. This function would unload deps of the file before running it, thus you can check the real-time update of the file without restart neovim.

It's recommended to do unit test with this function and builtin `assert`. Check `lua/omega/exist.test.lua` for an example.

## Functions

name|type|desc
-|-|-
dofile|fun(file_path: string)|dofile without cache
root_pattern|fun(...): string \| nil|search root directory
exist|fun(path: string): boolean|check if path exists
list_find|fun(list: any[], fn: fun(item: any): boolean): any \| nil|find item in a list
is_dir|fun(path: string): boolean|check if path is dir
exist_in_file|fun(text: string, path: string): boolean|check if text exists in file
get_selected_area|fun(): omega.Area|get selected area
get_selection|fun(): string \| nil|get selected text, get cursor word in normal mode, work in mode 'n', 'v' and 'V'
to_normal_mode|fun()|enter normal mode
spawn|fun(cmd: string, args?: string[], on_exit?: fun(ok: boolean, output?: string, err?: string), cwd?: string, env?: string): uv_process_t|spawn an command
