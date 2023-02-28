local utils = require('user.utils')
local dashboard = utils.load_plug('dashboard')

if dashboard == nil then
  return
end

--[[
db.custom_header  -- type can be nil,table or function(must be return table in function)
                  -- if not config will use default banner
db.custom_center  -- table type and in this table you can set icon,desc,shortcut,action keywords. desc must be exist and type is string
                  -- icon type is nil or string
                  -- icon_hl table type { fg ,bg} see `:h vim.api.nvim_set_hl` opts
                  -- shortcut type is nil or string also like icon
                  -- action type can be string or function or nil.
                  -- if you don't need any one of icon shortcut action ,you can ignore it.
db.custom_footer  -- type can be nil,table or function(must be return table in function)
db.preview_file_Path          -- string or function type that mean in function you can dynamic generate height width
db.preview_file_height        -- number type
db.preview_file_width         -- number type
db.preview_command            -- string type (can be ueberzug which only work in linux)
db.confirm_key                -- string type key that do confirm in center select
db.hide_statusline            -- boolean default is true.it will hide statusline in dashboard buffer and auto open in other buffer
db.hide_tabline               -- boolean default is true.it will hide tabline in dashboard buffer and auto open in other buffer
db.hide_winbar                -- boolean default is true.it will hide the winbar in dashboard buffer and auto open in other buffer
db.session_directory          -- string type the directory to store the session file
db.session_auto_save_on_exit  -- boolean default is false.it will auto-save the current session on neovim exit if a session exists and more than one buffer is loaded
db.session_verbose            -- boolean default true.it will display the session file path on SessionSave and SessionLoad
db.header_pad                 -- number type default is 1
db.center_pad                 -- number type default is 1
db.footer_pad                 -- number type default is 1

-- example of db.custom_center for new lua coder,the value of nil mean if you
-- don't need this filed you can not write it
db.custom_center = {
  {icon_hl={fg="color_code"},icon ="some icon",desc="some desc"} --correct
  { icon = 'some icon' desc = 'some description here' } --correct if you don't action filed
  { desc = 'some description here' }                    --correct if you don't action and icon filed
  { desc = 'some description here' action = 'Telescope find files'} --correct if you don't icon filed
}

-- Custom events
DBSessionSavePre   -- a custom user autocommand to add functionality before auto-saving the current session on exit
DBSessionSaveAfter -- a custom user autocommand to add functionality after auto-saving the current session on exit

-- Example: Close NvimTree buffer before auto-saving the current session
autocmd('User', {
    pattern = 'DBSessionSavePre',
    callback = function()
      pcall(vim.cmd, 'NvimTreeClose')
    end,
})


-- Highlight Group
DashboardHeader DashboardCenter DashboardShortCut DashboardFooter

-- Command

DashboardNewFile  -- if you like use `enew` to create file,Please use this command,it's wrap enew and restore the statsuline and tabline
SessionSave,SessionLoad,SessionDelete
]]


-- dashboard.setup(config)
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
  { icon = ' ',
    desc = 'Recently opened files',
    action = 'Telescope oldfiles only_cwd=true',
    shortcut = 'r' },
  { icon = ' ',
    desc = 'Find File',
    action = 'Telescope find_files find_command=rg,--hidden,--files',
    shortcut = 'f' },
  { icon = ' ',
    desc = 'File Browser',
    action = 'NvimTreeToggle',
    shortcut = 'e' },
  { icon = ' ',
    desc = 'Find Text',
    action = 'Telescope live_grep',
    shortcut = 'g' },
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
    mru = { limit = 10, icon = ' ', label = 'Old Files', },
    footer = {}, -- footer
  },
})

-- NOTE: See ftplugin/dashboard.lua for keymap configuration
