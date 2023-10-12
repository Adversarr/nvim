local utils = require('user.utils')
local dashboard = utils.load_plug('dashboard')
if dashboard == nil then
  return
end

local custom_header = {
  "     ___      .__   __. ",
  "    /   \\     |  \\ |  | ",
  "   /  ^  \\    |   \\|  | ",
  "  /  /_\\  \\   |  . `  | ",
  " /  _____  \\  |  |\\   | ",
  "/__/     \\__\\ |__| \\__| ",
  "",
}


local custom_center = {
  {
    icon = ' ',
    desc = 'Recently opened files',
    action = 'Telescope oldfiles only_cwd=true',
    shortcut = 'r'
  },
  {
    icon = ' ',
    desc = 'Find File',
    action = 'Telescope find_files find_command=rg,--hidden,--files',
    shortcut = 'f'
  },
  {
    icon = ' ',
    desc = 'File Browser',
    action = 'NvimTreeToggle',
    shortcut = 'e'
  },
  {
    icon = ' ',
    desc = 'Find Text',
    action = 'Telescope live_grep',
    shortcut = 'g'
  },
}

dashboard.setup({
  theme = 'hyper',
  config = {
    header = custom_header,
    -- week_header = custom_header,
    shortcut = custom_center,
    packages = { enable = true }, -- show how many plugins neovim loaded
    -- limit how many projects list, action when you press key or enter it will run this action.
    -- action can be a functino type, e.g.
    -- action = func(path) vim.cmd('Telescope find_files cwd=' .. path) end
    project = { enable = true, limit = 8, icon = ' ', label = 'Projects', action = 'Telescope find_files cwd=' },
    mru = { limit = 5, icon = ' ', label = 'Old Files', },
    footer = {}, -- footer
  },
})

-- NOTE: See ftplugin/dashboard.lua for keymap configuration
