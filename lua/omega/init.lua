---@class Omega
---@field dofile fun(file_path: string) [dofile without cache]
---@field exist_in_file fun(text: string, path: string): boolean [check if text exists in file]
---@field get_selected_area fun(): omega.Area [get selected area]
---@field get_selection fun(): string[] | nil [get selected text, get cursor expr in normal mode]
---@field to_normal_mode fun() [enter normal mode]
---@field get_timestamp fun(time?: string): number [get a millisecond-level timestamp, time format should be like '2022-01-01 00:00:00']
---@field get_human_readable_duration fun(start_time: number, end_time: number): string [get a human-readable duration between two millisecond-level timestamps]
---@field get_chars fun(str: string): string[] [get chars from a string, work for any transformation format]
---@field diff_text fun(old_text: string, new_text: string, callback: fun(text_edits: omega.TextEdit[])) [calculate text edits between two texts]
---@field get_line_ending fun(bufnr: number): string [get buffer specific line_ending character]
---@field get_offset_encoding fun(): string [get offset encoding]
---@field async fun(fn: fun()) [convert a synchronous function to an asynchronous one]
---@field await fun(fn: fun(resolve: fun(...: any[]))): any, any, ... [wait for a asynchronous function]
---@field Channel omega.Channel [spawn a process and enable bidirectional communication through stdin/stdout, check omega/channel.test.lua for examples]

local fns = {
	"dofile",
	"exist_in_file",
	"get_selected_area",
	"get_selection",
	"to_normal_mode",
	"get_timestamp",
	"get_human_readable_duration",
	"get_chars",
	"diff_text",
	"get_line_ending",
	"get_offset_encoding",
	"async",
	"await",
}

local function call(fn)
	return function(...)
		return require("omega." .. fn)[fn](...)
	end
end

---@type Omega
---@diagnostic disable-next-line: missing-fields
local M = {
	Channel = require("omega.channel"),
}
for _, fn in ipairs(fns) do
	---@diagnostic disable-next-line: assign-type-mismatch
	M[fn] = call(fn)
end

return M
