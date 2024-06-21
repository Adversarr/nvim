-- Markdown Preview:
vim.g.mkdp_filetypes = { "markdown" }
vim.g.mkdp_auto_start = 0
vim.g.mkdp_port = 13241
vim.g.mkdp_theme = 'dark'


-- vim-markdown
vim.api.nvim_set_var('vim_markdown_math', 1)
vim.api.nvim_set_var('vim_markdown_frontmatter', 1)
vim.api.nvim_set_var('vim_markdown_strikethrough', 1)
-- Not recommend: vim.api.nvim_set_option('conceallevel', 2)
vim.api.nvim_set_var('vim_markdown_folding_disabled', 1)
