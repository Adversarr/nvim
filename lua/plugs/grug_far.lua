local utils = require('user.utils')
local gf = utils.load_plug('grug-far')
if gf == nil then
  return
end
gf.setup {}
