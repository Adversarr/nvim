local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- if don't have packer.nvim, auto-install it
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACK_BOOTSTRAP = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path
    })

    print("Installing package manager packer.nvim into " .. install_path)
    vim.cmd "packadd packer.nvim"
end


local status_ok, packer = pcall(require, "packer")
if not status_ok then
    vim.notify("packer.nvim don't exists")
    return
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({border = "single"})
        end
    }
})

-- add package
return require('packer').startup{
    function(use)
      -- Packer can manage itself
      use 'wbthomason/packer.nvim'

      -- whichkey.
      use 'folke/which-key.nvim'

      -- colorschemes
      use 'morhetz/gruvbox'

      -- lspconfig
      use 'neovim/nvim-lspconfig'
      -- use 'williamboman/nvim-lsp-installer'
      use 'williamboman/mason.nvim'
      use 'williamboman/mason-lspconfig.nvim'

      -- clangd extension
      use "p00f/clangd_extensions.nvim"

      -- cmp completion and other enhence
      use 'hrsh7th/nvim-cmp'
      use 'hrsh7th/cmp-nvim-lsp'
      use 'hrsh7th/cmp-buffer'
      use 'hrsh7th/cmp-path'
      use 'hrsh7th/cmp-cmdline'
      use 'saadparwaiz1/cmp_luasnip'
      use 'hrsh7th/cmp-nvim-lsp-signature-help'
      use 'hrsh7th/cmp-nvim-lsp-document-symbol'

      use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
      }

      -- some snippet
      use 'L3MON4D3/LuaSnip'
      use 'rafamadriz/friendly-snippets'

      -- highlight and symbols
      use 'nvim-treesitter/nvim-treesitter'
      use 'windwp/nvim-autopairs'

      -- git intergation
      use "lewis6991/gitsigns.nvim"

      -- Commenter.
      use 'numToStr/Comment.nvim'

      -- file explorer
      use {
          "kyazdani42/nvim-tree.lua",
          requires = { 'kyazdani42/nvim-web-devicons' }
      }

      -- symbols outline
      use "simrat39/symbols-outline.nvim"

      -- using packer.nvim
      -- -- using packer.nvim
      use {
          'akinsho/bufferline.nvim',
          tag = "v2.*",
          requires = 'kyazdani42/nvim-web-devicons'
      }

      -- beautiful statesline
      use {
          "nvim-lualine/lualine.nvim",
          requires = { 'kyazdani42/nvim-web-devicons', opt = true }
      }

      use "junegunn/fzf"
      use "junegunn/fzf.vim"

      use "folke/which-key.nvim"

      use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })


      if PACK_BOOTSTRAP then
          require("packer").sync()
      end
  end,
  config = {
      display = {
          open_fn = function()
              return require('packer.util').float({ border = 'single' })
          end
      }
  }
}
