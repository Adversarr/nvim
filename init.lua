vim.g.mapleader  = " "
vim.g.maplocalleader = ""

require "user.keymaps"
require "user.plugins"
require "user.lspconfig"
require "user.cmp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.gitsigns"
require "user.tree"
require "user.symbolsoutline"
require "user.lualine"
require "user.bufferline"
require "user.fzf"

require "myself.options"
require "myself.cmake"
require "myself.filetype"

vim.cmd [[colorscheme gruvbox]]
