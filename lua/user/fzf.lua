local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>fl', '<cmd>Lines<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Buffers<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>fm', '<cmd>Marks<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-f>', '<cmd>Files .<CR>', opts)
