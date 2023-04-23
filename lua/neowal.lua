local M = {}

local cache_dir = os.getenv("XDG_CACHE_HOME") or os.getenv("HOME") .. "/.cache"
local pywal_colors = cache_dir .. "/wal/colors-wal.vim"

vim.api.nvim_cmd({ cmd = "source", args = { pywal_colors } }, {})

local blend_colors = require("neowal.utils").blend

-- stylua: ignore
local core_colors = {
  black   = "#111111",
  white   = "#cccccc",
  yellow  = "#ffff7f",
  blue    = "#7fc9ff",
  purple  = "#7f3f7f",
  orange  = "#ffb67f",
  green   = "#3f7f3f",
  red     = "#ff7f7f"
}

-- Define the blend ratio
local ratio = 0.4

-- Calculate blended colors
-- stylua: ignore
local palette = {
  bg      = vim.g.background,
	fg      = vim.g.foreground,

	color0  = vim.g.color0,
	color1  = vim.g.color1,
	color2  = vim.g.color2,
	color3  = vim.g.color3,
	color4  = vim.g.color4,
	color5  = vim.g.color5,
	color6  = vim.g.color6,
	color7  = vim.g.color7,
	color8  = vim.g.color8,
	color9  = vim.g.color9,
	color10 = vim.g.color10,
	color11 = vim.g.color11,
	color12 = vim.g.color12,
	color13 = vim.g.color13,
	color14 = vim.g.color14,
	color15 = vim.g.color15,

	yellow  = blend_colors(core_colors.yellow, vim.g.color1, ratio),
	blue    = blend_colors(core_colors.blue, vim.g.color2, ratio),
	purple  = blend_colors(core_colors.purple, vim.g.color3, ratio),
	orange  = blend_colors(core_colors.orange, vim.g.color4, ratio),
	green   = blend_colors(core_colors.green, vim.g.color5, ratio),
	red     = blend_colors(core_colors.red, vim.g.color6, ratio),
}

M.palette = palette

function M.setup()
	vim.g.colors_name = "neowal"



  -- stylua: ignore
  local syntax = {
    Identifier             = { clear = true },
    String                 = { fg = palette.color1 },
    Quote                  = { fg = palette.color1 },
    Character              = { fg = palette.color1 },
    SpecialComment         = { fg = palette.color8 },
    Comment                = { fg = palette.color8 },
    Repeat                 = { fg = palette.color5 },
    Conditional            = { fg = palette.color5 },
    Typedef                = { fg = palette.color2 },
    Tag                    = { fg = palette.color2 },
    Statement              = { fg = palette.color2 },
    Label                  = { fg = palette.color2 },
    Exception              = { fg = palette.color2 },
    PreCondit              = { fg = palette.color2 },
    StorageClass           = { fg = palette.color2 },
    Include                = { fg = palette.color4 },
    Define                 = { fg = palette.color5 },
    Macro                  = { fg = palette.color5 },
    PreProc                = { fg = palette.color5 },
    Boolean                = { fg = palette.color3 },
    Number                 = { fg = palette.color3 },
    Float                  = { fg = palette.color3 },
    Constant               = { fg = palette.color3 },
    Todo                   = { fg = palette.color3 },
    Type                   = { fg = palette.color3 },
    Special                = { fg = palette.color6 },
    Function               = { fg = palette.color6 },
    Error                  = { fg = palette.color7 },
    Title                  = { fg = palette.color8 },
    SpecialChar            = { fg = palette.color8 },
    Delimiter              = { fg = palette.color8 },
    Operator               = { fg = palette.color8 },
    SpecialKey             = { fg = palette.color8 },
    ["@none"]              = { fg = palette.color1 },
    ["@text.literal"]      = { link = "Comment", default = true },
    ["@text.reference"]    = { link = "Identifier", default = true },
    ["@text.title"]        = { link = "Title", default = true },
    ["@text.uri"]          = { link = "Underlined", default = true },
    ["@text.underline"]    = { link = "Underlined", default = true },
    ["@text.todo"]         = { link = "Todo", default = true },
    ["@comment"]           = { link = "Comment", default = true },
    ["@punctuation"]       = { link = "Delimiter", default = true },
    ["@constant"]          = { link = "Constant", default = true },
    ["@constant.builtin"]  = { link = "Special", default = true },
    ["@constant.macro"]    = { link = "Define", default = true },
    ["@define"]            = { link = "Define", default = true },
    ["@macro"]             = { link = "Macro", default = true },
    ["@string"]            = { link = "String", default = true },
    ["@string.escape"]     = { link = "SpecialChar", default = true },
    ["@string.special"]    = { link = "SpecialChar", default = true },
    ["@character"]         = { link = "Character", default = true },
    ["@character.special"] = { link = "SpecialChar", default = true },
    ["@number"]            = { link = "Number", default = true },
    ["@boolean"]           = { link = "Boolean", default = true },
    ["@float"]             = { link = "Float", default = true },
    ["@function"]          = { link = "Function", default = true },
    ["@function.builtin"]  = { link = "Special", default = true },
    ["@function.macro"]    = { link = "Macro", default = true },
    ["@parameter"]         = { link = "Identifier", default = true },
    ["@method"]            = { link = "Function", default = true },
    ["@field"]             = { link = "Special", default = true },
    ["@property"]          = { link = "Special", default = true },
    ["@constructor"]       = { link = "Special", default = true },
    ["@conditional"]       = { link = "Conditional", default = true },
    ["@repeat"]            = { link = "Repeat", default = true },
    ["@label"]             = { link = "Label", default = true },
    ["@operator"]          = { link = "Operator", default = true },
    ["@keyword"]           = { link = "Macro", default = true },
    ["@keyword.operator"]  = { link = "Macro", default = true },
    ["@exception"]         = { link = "Exception", default = true },
    ["@variable"]          = { link = "Identifier", default = true },
    ["@type"]              = { link = "Type", default = true },
    ["@type.definition"]   = { link = "Typedef", default = true },
    ["@storageclass"]      = { link = "StorageClass", default = true },
    ["@structure"]         = { link = "Structure", default = true },
    ["@namespace"]         = { link = "Identifier", default = true },
    ["@include"]           = { link = "Include", default = true },
    ["@preproc"]           = { link = "PreProc", default = true },
    ["@debug"]             = { link = "Debug", default = true },
    ["@tag"]               = { link = "Tag", default = true },
    ["@tag.delimiter"]     = { link = "Delimiter", default = true },
    ["@constructor.lua"]   = { link = "Delimiter", default = true },
  }

	if not pcall(require, "harmony") then
		vim.api.nvim_echo({ { "neowal: harmony.nvim is not installed.", "ErrorMsg" } }, true, {})
		return
	end

	local colors = require("harmony").colors

	-- @param groups string
	-- @return applies highlight based off properties in highlights table
	for group, gui in pairs(syntax) do
		if gui.clear then
			vim.api.nvim_cmd({ cmd = "highlight", args = { "clear", group } }, {})
		end

    -- stylua: ignore
    local keys = {
      "fg", "bg", "sp", "blend", "bold", "standout", "underline",
      "undercurl", "underdouble", "underdotted", "strikethrough", "italic", "reverse",
      "nocombine",  "cterm", "ctermfg", "ctermbg", "default", "link"
    }

		local attrs = {}

		for _, key in ipairs(keys) do
			attrs[key] = colors[gui[key]] or gui[key]
		end

		vim.api.nvim_set_hl(0, group, attrs)
	end

  -- stylua: ignore
	require("harmony").register({
		["neowal"] = {
			bg     = palette.bg,
			fg     = palette.fg,
			red    = palette.red,
			green  = palette.green,
			yellow = palette.yellow,
			blue   = palette.blue,
			purple = palette.purple,
			accent = palette.blue,
      highlights = {
        LspReferenceRead = { bg = blend_colors(palette.color2, vim.g.background, 0.90)},
        LspReferenceText = { bg = blend_colors(palette.color2, vim.g.background, 0.90)},
        LspReferenceWrite = { bg = blend_colors(palette.color2, vim.g.background, 0.90)},
      }
		},
	})
end

return M
