local utils = require('user.utils')
require('plugs.neodev')
local mason = utils.load_plug('mason')
local masonconfig = utils.load_plug('mason-lspconfig')
if mason == nil or masonconfig == nil then
  return
end

mason.setup {
  -- A list of servers to automatically install if they're not already installed. Example: { "rust_analyzer@nightly", "lua_ls" }
  -- This setting has no relation with the `automatic_installation` setting.
  ---@type string[]
  ensure_installed = { "typst_lsp", 'clangd', },

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


local lspconfig = utils.load_plug('lspconfig')
if lspconfig == nil then
  return
end



-- Load required lsp.
lspconfig.typst_lsp.setup(require("lspc.typst_lsp"))
lspconfig.clangd.setup(require('lspc.clangd'))
lspconfig.lua_ls.setup(require('lspc.lua_ls'))
lspconfig.cmake.setup {
  root_dir = lspconfig.util.root_pattern('CMakePresets.json', 'CTestConfig.cmake', '.git', 'build', 'cmake',
    "CMakeLists.txt")
}
lspconfig.pyright.setup(require('lspc.pyright'))
