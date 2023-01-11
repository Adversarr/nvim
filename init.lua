COLORSCHEME = 'onedarker'
ENABLE_FZF = true

require "user.plugins"
require "user.general"

-- Which key load first
require "plugs.which-key"
require 'plugs.notify'


-- Ui:
require "plugs.nvim-tree"
require "plugs.lualine"
require "plugs.bufferline"
require "plugs.gitsigns"
require "plugs.telescope"
require "plugs.toggleterm"
require 'plugs.trouble'


-- Editor:
require 'plugs.todocomment'
require "plugs.comment"
require 'plugs.goto-preview'
require 'plugs.treesitter'

-- Languages:
require "plugs.coc"
require 'plugs.markdown'
require 'plugs.glsl'


-- After load everything, apply keymaps.
require "user.keymaps"