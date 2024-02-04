local utils = require "user.utils"
local config = {
  undercurl = true,
  underline = true,
  bold = true,
  -- italic = false,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = true,
}

local plug = utils.load_plug('gruvbox')
if plug == nil then
  return
end

vim.o.background = "dark" -- or "light" for light mode
plug.setup(config)
