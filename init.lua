require "config"
require "user.plugins"
require "user.general"

-- Which key load first
require "plugs.which-key"
require 'plugs.notify'


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

-- Languages:
require "plugs.coc"
require 'plugs.markdown'
require 'plugs.glsl'
require "plugs.vimtex"

-- After load everything, apply keymaps.
require "user.keymaps"
function run_job()
  local Job = require'plenary.job'
  Job:new({
    command = 'ls',
    args = { '' },
    cwd = '~',
    env = {},
    on_exit = function(j, return_val)
      print(return_val)
      -- print(j:result())
    end,
    on_stdout = function(j, retval) 
      print(retval)
    end
  }):sync() -- or start()
end
vim.api.nvim_create_user_command("HiLS", run_job, {})
