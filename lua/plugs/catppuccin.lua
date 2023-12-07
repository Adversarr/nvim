
local utils = require "user.utils"

local plug = utils.load_plug('catppuccin')
if plug == nil then
  return
end
plug.setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = false,
    dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.5,
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = false,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        notify = true,
        mini = false,

        which_key = true,

        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic", "bold" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },

        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})


