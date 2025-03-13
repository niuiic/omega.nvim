---@meta

---@class omega.Area
---@field start_lnum number
---@field start_col number
---@field end_lnum number
---@field end_col number

---@class omega.TextEdit
---@field range omega.Range
---@field newText string

---@class omega.Range
---@field start omega.Position
---@field end omega.Position

---@class omega.Position
---@field line number
---@field character number

---@class omega.Channel
---@field new fun(self: omega.Channel, cmd: string[], opts: vim.SystemOpts | nil): omega.Channel
---@field send fun(self: omega.Channel, data: string | nil) send nil to close the stream
---@field read fun(self: omega.Channel, callback: fun(data: string))
---@field close fun(self: omega.Channel)
