-- This file can be loaded by calling `lua require('pakettiale')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

require('pakettiale.set')
require('pakettiale.wk')

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'sainnhe/sonokai'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'nvim-treesitter/nvim-treesitter'
  use 'nvim-treesitter/playground'
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip'
  use 'onsails/lspkind.nvim'
  use 'folke/which-key.nvim'
  use 'jose-elias-alvarez/typescript.nvim'

  use {
    'MrcJkb/haskell-tools.nvim',
    requires = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim', -- optional
    },
    tag = '1.2.0' -- latest as of 2022-11-13
  }

  use 'AndrewRadev/linediff.vim'
end)
