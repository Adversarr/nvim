vim.opt.backup = false                                       -- creates a backup file
vim.opt.clipboard = "unnamedplus"                            -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                                        -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999"                                -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0                                     -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                               -- the encoding written to a file
vim.opt.foldmethod = "expr"                                  -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"                                 -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.foldlevel = 5
vim.opt.guifont = "CodeNewRoman Nerd Font:h16:##e-antialias" -- the font used in graphical neovim applications
vim.opt.linespace = 0
vim.opt.hidden = true                                        -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true                                      -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                                    -- ignore case in search patterns
vim.opt.mouse = "a"                                          -- allow the mouse to be used in neovim
vim.opt.pumheight = 10                                       -- pop up menu height
vim.opt.showmode = false                                     -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2                                      -- always show tabs
vim.opt.smartcase = true                                     -- smart case
vim.opt.smartindent = true                                   -- make indenting smarter again
vim.opt.splitbelow = true                                    -- force all horizontal splits to go below current window
vim.opt.splitright = true                                    -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                                     -- creates a swapfile
vim.opt.termguicolors = true                                 -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 300                                     -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true                                         -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim"                   -- what the title of the window will be set to
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile = true                                      -- enable persistent undo
vim.opt.updatetime = 150                                     -- faster completion
vim.opt.writebackup = false                                  -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.expandtab = true                                     -- convert tabs to spaces
vim.opt.shiftwidth = 2                                       -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2                                          -- insert 2 spaces for a tab
vim.opt.cursorline = true                                    -- highlight the current line
vim.opt.number = true                                        -- set numbered lines
vim.opt.relativenumber = true                                -- set relative numbered lines
vim.opt.numberwidth = 4                                      -- set number column width to 2 {default 4}
vim.opt.signcolumn =
"yes"                                                        -- always show the sign column otherwise it would shift the text each time
vim.opt.wrap = false                                         -- display lines as one long line
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.sidescrolloff = 8

vim.cmd("colorscheme " .. COLORSCHEME)
vim.g.mapleader = " "

-- For neovide:

-- https://neovide.dev/faq.html#how-can-i-use-cmd-ccmd-v-to-copy-and-paste
if vim.g.neovide then
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_no_idle = true
  vim.g.neovide_input_macos_alt_is_meta = true
  vim.g.neovide_input_use_logo = 1            -- enable use of the logo (cmd) key
  vim.keymap.set('n', '<D-s>', ':w<CR>')      -- Save
  vim.keymap.set('v', '<D-c>', '"+y')         -- Copy
  vim.keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
  vim.o.mousescroll = "ver:3,hor:0"
  vim.g.neovide_cursor_animate_command_line = false
  vim.g.neovide_cursor_antialiasing = true
  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.85))
  end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 0.8
  vim.g.neovide_scale_factor=1.0
  vim.g.transparency = 0.85
  vim.g.neovide_background_color = "#0f1117" .. alpha()
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5
end

-- Allow clipboard copy paste in neovim
vim.g.neovide_input_use_logo = 1
vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })
