return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

	-- Essential plugins
	use 'janko-m/vim-test'
	use 'pangloss/vim-javascript'
	use 'pbrisbin/vim-mkdir'
	use 'tpope/vim-bundler'
	use 'tpope/vim-endwise'
	use 'tpope/vim-eunuch'
	use 'tpope/vim-fugitive'
	use 'tpope/vim-projectionist'
	use 'tpope/vim-rails'
	use 'tpope/vim-rake'
	use 'tpope/vim-repeat'
	use 'tpope/vim-rhubarb'
	use 'tpope/vim-surround'
	use 'tpope/vim-unimpaired'
	use 'vim-ruby/vim-ruby'
	use 'vim-scripts/tComment'

	-- Aesthetics
	use 'edkolev/tmuxline.vim'
	use 'andersevenrud/nordic.nvim'
  use 'eddyekofo94/gruvbox-flat.nvim'

	-- NeoVim Utilities
	use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'}
	use {'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons'}}
	use {'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons', opt = true}}
  use {'akinsho/bufferline.nvim', requires = {'kyazdani42/nvim-web-devicons'} }
	use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
	use {'nvim-telescope/telescope.nvim', requires = {'nvim-lua/plenary.nvim'} }
	use {'ms-jpq/coq_nvim', branch='coq'}
	use {'ms-jpq/coq.artifacts', branch='artifacts'}
	use 'neovim/nvim-lspconfig'
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'kyazdani42/nvim-web-devicons'
	use 'norcalli/snippets.nvim'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'onsails/lspkind-nvim'
	use 'folke/lsp-colors.nvim'

end)
