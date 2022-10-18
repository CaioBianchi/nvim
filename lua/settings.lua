-- Settings
local o = vim.o
o.encoding = 'utf-8'
o.backspace = '2'
o.history = 50
o.ruler = true
o.showcmd = true
o.incsearch = true
o.autowrite = true
o.modelines = 0
o.syntax = 'on'
o.termguicolors = true
o.tabstop = 2
o.shiftwidth = 2
o.shiftround = true
o.expandtab = true
o.colorcolumn = '+1'
o.number = true
o.numberwidth = 5
o.tags = '.git/tags'
o.splitbelow = true
o.splitright = true
o.spellfile='$HOME/.vim-spell-en.utf-8.add'
o.mouse = 'a'
o.textwidth = 160
o.cursorline = true
o.background = 'dark'
o.wildmenu = true
o.termguicolors = true
-- o.wildmode = "list:longest,full"
o.laststatus = 3
o.completeopt = "menuone,noselect"
o.clipboard = o.clipboard .. 'unnamedplus'

-- Global Configs
local g = vim.g
g.mapleader = ' '
g.is_posix = 1
g.vim_json_conceal = 0
vim.cmd([[
  colorscheme github_dark
  filetype plugin indent on
  highlight Comment gui=italic
  highlight link CompeDocumentation NormalFloat

  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
