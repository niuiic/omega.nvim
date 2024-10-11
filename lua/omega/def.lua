---@meta

---@class Omega
---@field dofile fun(file_path: string) dofile without cache
---@field root_pattern fun(...): string | nil search root directory
---@field exist fun(path: string): boolean check if path exists
