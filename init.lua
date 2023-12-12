require "config"
require "user.plugins"
require "user.general"

-- Which key load first
require "plugs.which-key"
require 'plugs.notify'

-- colorscheme
require 'plugs.gruvbox'
require 'plugs.catppuccin'

-- Ui:
-- require 'plugs.dashboard'
require "plugs.nvim-tree"
require "plugs.lualine"
require "plugs.bufferline" -- catppuccin says: bufferline should be loaded after.
require "plugs.gitsigns"
require "plugs.telescope"
require 'plugs.cmaketools'
require "plugs.toggleterm"

-- Editor:
require 'plugs.todocomment'
require "plugs.comment"
require 'plugs.treesitter'
require 'plugs.indent_blankline'
require 'plugs.autopair'
require 'plugs.neogen'
require "plugs.trouble"
require "plugs.copilot"

-- Languages:
-- ndev should be loaded before lsp.
require 'plugs.luasnip'
require 'plugs.markdown'
require 'plugs.glsl'
require "plugs.vimtex"
require "plugs.typst"
require "plugs.lsp"
require 'plugs.cmp'

-- Debugger.
require "plugs.dap"
require "plugs.dapui"
require "plugs.symbolsoutline"

-- After load everything, apply keymaps.
require "user.keymaps"
