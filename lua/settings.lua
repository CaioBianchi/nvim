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
o.wildmode = "list:longest,full"
o.completeopt = "menu,menuone,noselect"
o.clipboard = o.clipboard .. 'unnamedplus'

-- Global Configs
local g = vim.g
g.mapleader = ' '
g.is_posix = 1
g.vim_json_conceal = 0
vim.cmd([[
  colorscheme gruvbox-flat
  filetype plugin indent on
  highlight Comment gui=italic
  highlight link CompeDocumentation NormalFloat

  augroup vimrcEx
    autocmd!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    " Set syntax highlighting for specific file types
    autocmd BufRead,BufNewFile *.md set filetype=markdown
    autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
    autocmd BufRead,BufNewFile
      \ aliases.local,
      \zshenv.local,zlogin.local,zlogout.local,zshrc.local,zprofile.local,
      \*/zsh/configs/*
      \ set filetype=sh
    autocmd BufRead,BufNewFile gitconfig.local set filetype=gitconfig
    autocmd BufRead,BufNewFile tmux.conf.local set filetype=tmux
    autocmd BufRead,BufNewFile vimrc.local set filetype=vim
  augroup END

  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
