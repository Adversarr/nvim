vim.g.tex_conceal = 'abdmgs'
vim.g.tex_flavor = 'latex'
vim.opt.conceallevel = 2
-- if OS is mac, set the viewer to skim.
if vim.fn.has('mac') then
  vim.g.vimtex_view_method = 'skim'
  vim.g.vimtex_quickfix_mode = 0
  vim.g.vimtex_view_skim_sync = 1
  vim.g.vimtex_view_skim_active = 1
end

vim.g.vimtex_toc_config = {
  name = 'TOC',
  split_width = 30,
  todo_sorted = 0,
  show_help = 0,
  show_numbers = 1,
}

vim.g.vimtex_compiler_latexmk_engines = {
  _ = '-xelatex'
}

vim.g.vimtex_compiler_latexmk = {
  build_dir = '',
  callback = 1,
  continuous = 1,
  executable = 'latexmk',
  hooks = {},
  options = {
    '-xelatex',
    '-verbose',
    '-file-line-error',
    '-synctex=1',
    '-interaction=nonstopmode',
  },
}



local M = {
  setup = function()
    -- if OS is mac, set the viewer to skim.
    if vim.fn.has('mac') then
      vim.g.vimtex_view_method = 'skim'
      vim.g.vimtex_quickfix_mode = 0
      vim.g.vimtex_view_skim_sync = 1
      vim.g.vimtex_view_skim_active = 1
    end
    vim.api.nvim_create_augroup("vimtex_mac", {})
    vim.api.nvim_create_autocmd("User", {
      group = 'vimtex_mac',
      pattern = 'VimtexEventCompileSuccess',
      callback = function()
        require('notify').notify('Compilation Success!', vim.log.levels.INFO)
      end
    })

    -- TODO: Add other autocmd.
 end
}

return M
