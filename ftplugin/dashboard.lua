local buf = vim.api.nvim_get_current_buf()
local set_buf_km = function(lhs, rhs)
  vim.api.nvim_buf_set_keymap(buf, 'n', lhs, rhs,
    {noremap=true, silent=true})
end


set_buf_km('q', "<cmd>q<cr>")
set_buf_km('f', '<cmd>Telescope find_files<cr>')
set_buf_km('e', "<cmd>NvimTreeToggle<cr>")
set_buf_km('g', '<cmd>Telescope live_grep use_regex=true<cr>')
set_buf_km('r', "<cmd>Telescope oldfiles only_cwd=true<cr>")