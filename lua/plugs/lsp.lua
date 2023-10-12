local utils = require('user.utils')
local mason = utils.load_plug('mason')
local masonconfig = utils.load_plug('mason-lspconfig')
if mason == nil or masonconfig == nil then
  return
end

mason.setup {
  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
  -- This setting has no relation with the `automatic_installation` setting.
  ---@type string[]
  ensure_installed = { "typst_lsp" },

  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  ---@type boolean
  automatic_installation = false,

  -- See `:h mason-lspconfig.setup_handlers()`
  ---@type table<string, fun(server_name: string)>?
  handlers = nil,
}
masonconfig.setup {}

require'lspconfig'.typst_lsp.setup{
	settings = {
		exportPdf = "onSave" -- Choose onType, onSave or never.
        -- serverPath = "" -- Normally, there is no need to uncomment it.
	}
}
