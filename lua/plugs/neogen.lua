local utils = require('user.utils')
local neogen = utils.load_plug('neogen')
if neogen == nil then
    return
end

neogen.setup {
  languages = {
    ['cpp.doxygen'] = require('neogen.configurations.cpp'),
  }
}

