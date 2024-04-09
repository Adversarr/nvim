return {
  cmd = {
    "clangd",
    "-j=8",
    "--header-insertion=never",
    "--completion-style=detailed",
    "--ranking-model=heuristics",
    "--enable-config",
    "--background-index",
    "--function-arg-placeholders=0",
    "--clang-tidy",
    "--offset-encoding=utf-8",
  },
  capabilities = {offsetEncoding = {'utf-8'}},
  init_options = {
    clangdFileStatus = true,
    clangdSemanticHighlighting = true
  },
  filetypes = { 'c', 'cpp', 'cxx', 'cc' },
  root_dir = function() vim.fn.getcwd() end,
  settings = {
    ['clangd'] = {
      ['compilationDatabasePath'] = 'build',
      ['fallbackFlags'] = { '-std=c++17' }
    }
  }

}
