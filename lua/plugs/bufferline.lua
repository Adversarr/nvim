-- Highly recommended: vim.opt.termguicolors = true
-- Reference: LunarVim
local function diagnostics_indicator(num, _, diagnostics, _)
  local result = {}
  local symbols = {
    error = "",
    warning = "",
    info = ""
  }
  for name, count in pairs(diagnostics) do
    if symbols[name] and count > 0 then
      table.insert(result, symbols[name] .. " " .. count)
    end
  end
  result = table.concat(result, " ")
  return #result > 0 and result or ""
end



local config = {
  options = {
      mode = "buffer", -- set to "tabs" to only show tabpages instead, default = "buffer"
      numbers = "none", -- | "ordinal" | "buffer_id" | "both",
      close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
      right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
      middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
      indicator = {
          icon = '▎', -- this should be omitted if indicator style is not 'icon'
          style = 'none' -- 'icon' | 'underline' | 'none',
      },
      buffer_close_icon = '󰖭',
      modified_icon = '●',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      --- name_formatter can be used to change the buffer's label in the bufferline.
      --- Please note some names can/will break the
      --- bufferline so use this at your discretion knowing that it has
      --- some limitations that will *NOT* be fixed.
      name_formatter = function(buf)  -- buf contains:
            -- name                | str        | the basename of the active file
            -- path                | str        | the full path of the active file
            -- bufnr (buffer only) | int        | the number of the active buffer
            -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
            -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
      end,
      max_name_length = 12,
      max_prefix_length = 9, -- prefix used when a buffer is de-duplicated
      truncate_names = true, -- whether or not tab names should be truncated
      tab_size = 18,
      diagnostics = 'nvim_lsp',    -- false | "nvim_lsp" | "coc",
      diagnostics_update_in_insert = false,
      -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
      diagnostics_indicator = diagnostics_indicator,
      -- NOTE: this will be called a lot so don't do any heavy processing here
      custom_filter = function(buf_number, buf_numbers)
          -- filter out filetypes you don't want to see
          if vim.bo[buf_number].filetype ~= "NvimTree" then
              return true
          end
          if vim.bo[buf_number].filetype ~= "Vista" then
            return true
          end
          if vim.bo[buf_number].filetype ~= "list" then
            return true
          end
          if vim.bo[buf_number].filetype ~= "dashboard" then
            return true
          end
          if vim.bo[buf_number].filetype ~= "coctree" then
            return true
          end
          if vim.bo[buf_number].filetype ~= "help" then
            return true
          end
          -- -- filter out by buffer name
          -- if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
          --     return true
          -- end
          -- -- filter out based on arbitrary rules
          -- -- e.g. filter out vim wiki buffer from tabline in your work repo
          -- if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
          --     return true
          -- end
          -- -- filter out by it's index number in list (don't show first buffer)
          -- if buf_numbers[1] ~= buf_number then
          --     return true
          -- end
      end,
      offsets = {
          {
              filetype = "NvimTree",
              text = "File Explorer", -- | function ,
              text_align = "center", -- "left" | "center" | "right",
              separator = true
          }
      },
      color_icons = true ,-- true | false, -- whether or not to add the filetype icon highlights
      show_buffer_icons = true, -- true | false, -- disable filetype icons for buffers
      -- show_buffer_close_icons = true, -- true | false,
      -- show_buffer_default_icon = true, -- true | false, -- whether or not an unrecognised filetype should show a default icon
      show_close_icon = false,
      show_tab_indicators = true,
      show_duplicate_prefix = false, -- whether to show duplicate buffer prefix
      persist_buffer_sort = false, -- whether or not custom sorted buffers should persist
      -- can also be a table containing 2 custom separators
      -- [focused and unfocused]. eg: { '|', '|' }
      separator_style = "thin", -- "slant" | "thick" | "thin" | { 'any', 'any' },
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      hover = {
          enabled = true,
          delay = 200,
          reveal = {'close'}
      },
      sort_by = 'insert_at_end'
      --[[
        'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
          -- add custom logic
          return buffer_a.modified > buffer_b.modified
        end
      ]]
  },
  highlights = require("catppuccin.groups.integrations.bufferline").get(),
}


local utils = require('user.utils')
local bufferline = utils.load_plug('bufferline')

if bufferline == nil then
  return
end


vim.opt.termguicolors = true
bufferline.setup(config)
-- vim.cmd [[ autocmd BufWrite * lua require('bufferline.diagnostics').refresh_coc_diagnostics()]]


