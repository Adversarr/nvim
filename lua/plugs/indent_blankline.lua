local utils = require "user.utils"
local config = {
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = true,
  show_end_of_line = true
}

local plug = utils.load_plug('indent_blankline')
if plug == nil then
  return
end
plug.setup(config)
vim.g.indent_blankline_char_blankline = '┆'
vim.g.indent_blankline_show_end_of_line = true
vim.g.indent_blankline_filetype_exclude = {
  "lspinfo",
  "packer",
  "checkhealth",
  "help",
  "man",
  "",
  "dashboard",
  "NvimTree",
  "list"
}

vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"

