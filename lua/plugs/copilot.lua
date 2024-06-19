vim.g.copilot_proxy = 'https://127.0.0.1:7890'
vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)')
vim.g.copilot_no_tab_map = true

vim.g.copilot_filetypes = {
  python=true,
  cpp=true,
  cuda=true,
  c=true,
  latex=true,
  lua=true
}


