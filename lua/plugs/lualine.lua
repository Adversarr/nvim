local utils = require('user.utils')
local lualine = utils.load_plug('lualine')
if lualine == nil then
  return
end


local function getCurrentFunctionSymbol()
  local fname = vim.b.coc_current_function
  return fname
end

local function get_coc_status()
  return vim.g.coc_status
end

local config = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = { "NvimTree", "ToggleTerm", "Top", "", 'list', "dashboard" },
      winbar = { "NvimTree", "ToggleTerm", "Top", "coctree'", "", 'list', "dashboard" },
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { { 'mode', fmt = function(str) return str:sub(1, 1) end } },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { {
      'filename',
      file_status = true,     -- Displays file status (readonly status, modified status)
      newfile_status = false, -- Display new file status (new file means no write after created)
      path = 1,               -- 0: Just the filename
      -- 1: Relative path
      -- 2: Absolute path
      -- 3: Absolute path, with tilde as the home directory

      shorting_target = 20, -- Shortens path to leave 40 spaces in the window
      -- for other components. (terrible name, any suggestions?)
      symbols = {
        modified = '[+]',      -- Text to show when the file is modified.
        readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
        unnamed = '[No Name]', -- Text to show for unnamed buffers.
        newfile = '[New]',     -- Text to show for newly created file before first write
      }
    },
      'b:coc_current_function',
      'g:coc_status',
    },
    lualine_x = { 'encoding', 'filetype' },
    lualine_y = { 'searchcount' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

lualine.setup(config)
