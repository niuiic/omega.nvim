# omega.nvim

Lua development utilities for Neovim.

All functions are lazy load.

[More neovim plugins](https://github.com/niuiic/awesome-neovim-plugins)

## Install

- lazy.nvim

```lua
{"niuiic/omega.nvim", build = "cd rs && cargo build --release"}
```

## Dev

Run current lua file with
`require("omega").dofile(vim.api.nvim_buf_get_name(0))`. This function would
unload deps of the file before running it, thus you can check the real-time
update of the file without restart neovim.

It's recommended to do unit test with this function and builtin `assert`. Check
`lua/omega/exist_in_file.test.lua` for an example.

## Functions

name|type|desc
-|-|-
dofile|fun(file_path: string)|dofile without cache
exist_in_file|fun(text: string, path: string): boolean|check if text exists in file
get_selected_area|fun(): omega.Area|get selected area
get_selection|fun(): string[] \| nil|get selected text, get cursor expr in normal mode
to_normal_mode|fun()|enter normal mode
get_timestamp|fun(time?: string): number|get a millisecond-level timestamp, time format should be like '2022-01-01 00:00:00'
get_human_readable_duration|fun(start_time: number, end_time: number): string|get a human-readable duration between two millisecond-level timestamps
get_chars|fun(str: string): string[]|get chars from a string, work for any transformation format
diff_text|fun(old_text: string, new_text: string, callback: fun(text_edits: omega.TextEdit[]))|calculate text edits between two texts
get_line_ending|fun(bufnr: number): string|get buffer specific line_ending character
get_offset_encoding|fun(): string|get offset encoding
async|fun(fn: fun())|convert a synchronous function to an asynchronous one
await|fun(fn: fun(resolve: fun(...: any[]))): any, any, ...|wait for a asynchronous function
Channel|omega.Channel|spawn a process and enable bidirectional communication through stdin/stdout, check omega/channel.test.lua for examples

## Useful Neovim Builtin Functions

| name               | usage                        |
| ------------------ | ---------------------------- |
| vim.fn.isdirectory | check if path is a directory |
| vim.uv.fs_stat     | check if path exist          |
| vim.fs.root        | find root directory          |
| vim.system         | spawn a command              |
| vim.iter           | lua list operation           |
| vim.fs.joinpath    | concat path                  |