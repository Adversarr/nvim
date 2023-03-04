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
require 'plugs.dashboard'
require "plugs.nvim-tree"
require "plugs.lualine"
require "plugs.bufferline"
require "plugs.gitsigns"
require "plugs.telescope"
require "plugs.toggleterm"



-- Editor:
require 'plugs.todocomment'
require "plugs.comment"
require 'plugs.treesitter'
require 'plugs.indent_blankline'
require 'plugs.autopair'
require 'plugs.neogen'

-- Languages:
require "plugs.coc"
require 'plugs.markdown'
require 'plugs.glsl'
require "plugs.vimtex"

-- After load everything, apply keymaps.
require "user.keymaps"
