local utils = require('user.utils')
local notify = utils.load_plug('notify')
if notify == nil then
    return
end

notify.setup {
  background_colour = "Normal",
  fps = 30,
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = ""
  },
  level = 2,
  minimum_width = 40,
  render = "default",
  stages = "fade_in_slide_out",
  timeout = 1500,
  top_down = true
}

-- Replace original notify.
vim.notify = notify.notify