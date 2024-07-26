local default_capabilities = {
  textDocument = {
    completion = {
      editsNearCursor = true,
    },
  },
  offsetEncoding = 'utf-8'
}
return {
  cmd = {
    "clangd",
    "-j=8",
    "--header-insertion=never",
    "--ranking-model=heuristics",
    "--enable-config",
    "--background-index",
    "--clang-tidy",
  },
  capabilities = default_capabilities,
  init_options = {
    clangdFileStatus = true,
    clangdSemanticHighlighting = true
  },
  filetypes = { 'c', 'cpp', 'cxx', 'cc', 'cuda' },
  root_dir = function() vim.fn.getcwd() end,
  settings = {
    ['clangd'] = {
      ['compilationDatabasePath'] = 'build',
      ['fallbackFlags'] = { '-std=c++17' }
    }
  },
  on_attach = function(client, bufnr)
    --[[
      autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    --]]
    -- vim.api.nvim_create_autocmd('CursorHold', {
    --   pattern = "<buffer>",
    --   callback = function()
    --     vim.lsp.buf.document_highlight()
    --   end
    -- })
    -- vim.api.nvim_create_autocmd('CursorHoldI', {
    --   pattern = "<buffer>",
    --   callback = function()
    --     vim.lsp.buf.document_highlight()
    --   end
    -- })
    -- vim.api.nvim_create_autocmd('CursorMoved', {
    --   pattern = "<buffer>",
    --   callback = function()
    --     vim.lsp.buf.clear_references()
    --   end
    -- })
  end

}
