local utils = require('user.utils')
local bufferline = utils.load_plug('bufferline')

if bufferline == nil then
  return
end

-- Highly recommended: vim.opt.termguicolors = true
local config = {}

bufferline.setup(config)