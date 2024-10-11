# omega.nvim

## Functions

name|type|desc
-|-|-
dofile|fun(file_path: string)|dofile without cache
root_pattern|fun(...): string \| nil|search root directory
exist|fun(path: string): boolean|check if path exists
is_dir|fun(path: string): boolean|check if path is dir
exist_in_file|fun(text: string, path: string): boolean|check if text exists in file
get_selected_area|fun(): omega.Area|get selected area
get_selection|fun(): string \| nil|get selected text, get cursor word in normal mode, work in mode 'n', 'v' and 'V'
to_normal_mode|fun()|enter normal mode
