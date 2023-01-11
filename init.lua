COLORSCHEME = 'onedarker'
ENABLE_FZF = true

require "user.plugins"
require "user.general"


require "plugs.which-key"
-- Ui:
require "plugs.nvim-tree"
require "plugs.lualine"
require "plugs.bufferline"
require "plugs.gitsigns"
require "plugs.telescope"

-- Editor:
require "plugs.comment"
require "plugs.coc"

-- After load everything, apply keymaps.
require "user.keymaps"