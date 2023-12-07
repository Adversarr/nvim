vim.g.typst_pdf_viewer = 'skim'

vim.api.nvim_create_augroup("Typst", {clear=false})
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  group = "Typst",
  pattern = "*.typ",
  -- command = "setl formatexpr=CocAction('formatSelected')",
  command='set ft=typst',
  desc = "Setup formatexpr specified filetype(s)."
})
