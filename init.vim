"https://blog.nikfp.com/how-to-install-and-set-up-neovim-on-windows
":h lua-guide

let s:vimPlugPath = stdpath('data').'/site/autoload/plug.vim'
let s:autoloadDir = stdpath('data').'/site/autoload'
if empty(glob(s:vimPlugPath))
	if !isdirectory(s:autoloadDir)
		call mkdir(s:autoloadDir, 'p')
	endif
	execute '!curl -fLo "'.s:vimPlugPath.'" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	execute 'source "'.s:vimPlugPath.'"'
endif

" Delete temporary variables.
for k in keys(s:)
	"echo 's:'.k.'='s:[k]
	unlet s:[k]
endfor

" May help performance on some systems (maybe Windows).
"set nofsync

" Set <Leader> and <LocalLeader> key binds for custom prefixing of keybinds
" from plugins.
let mapleader = ' '
let maplocalleader = '\'

" Set to true if you have a Nerd Font installed and selected in the terminal
" Some nerd fonts can be downloaded from https://www.nerdfonts.com/font-downloads
lua vim.g.have_nerd_font = true

set encoding=utf-8

" Setup line number column.
set number
set relativenumber

set autowriteall
set cursorline
set nofoldenable
set foldmethod=indent

" Set whitespace character visualization.
set list
set listchars+=space:·

set colorcolumn=80,100
set smartcase
set ignorecase
set tags=./tags,tags;$HOME

" Line wrapping
set wrap
set breakindent

" Settings for controlling indentation.
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set noexpandtab
set confirm

" Switching between previous and next split.
nmap <C-l> <C-w>w
nmap <C-h> <C-w>W

" Switching between previous and next buffer in current split.
nmap <C-PageUp>   <Cmd>bp<Enter>
nmap <C-PageDown> <Cmd>bn<Enter>

" Invoking :make command quickly.
nmap m <Cmd>make<Enter>

" Close current buffer without closing window/split. Basically moves to
" previous buffer, creates new split, returns to original buffer and closes
" the split.
nmap <C-q> <Cmd>bp<Bar>sp<Bar>bn<Bar>bd<Enter>

" Clear highlights on search when pressing <Esc> in normal mode
"  See `:help hlsearch`
nmap <Esc> <Cmd>nohlsearch<CR>

" Use `:PlugInstall` after adding a plugin to install it.
call plug#begin()

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-lualine/lualine.nvim'
Plug 'ziglang/zig.vim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'mason-org/mason.nvim'
Plug 'Civitasv/cmake-tools.nvim'

" plug#end() automatically executes
" 	:filetype plugin indent on
" 	:syntax enable
call plug#end()

nnoremap <C-p> <Cmd>Telescope find_files<Enter>

lua << EOF
require('lualine').setup({
	options = {
		theme = 'ayu_dark',
	},
})
require('nvim-treesitter.configs').setup({
	highlight = { enable = true }
})
require('mason').setup()
EOF

nmap <Leader>m   <Cmd>CMakeBuild<Enter>
nmap <Leader>ccp <Cmd>CMakeSelectConfigurePreset<Enter>
nmap <Leader>cbp <Cmd>CMakeSelectBuildPreset<Enter>
