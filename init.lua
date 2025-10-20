-- https://blog.nikfp.com/how-to-install-and-set-up-neovim-on-windows
-- :h lua-guide

local vimPlugPath = vim.fn.stdpath('data')..'/site/autoload/plug.vim'
local autoloadDir = vim.fn.stdpath('data')..'/site/autoload'
local runPlugInstall = false
if vim.fn.empty(vim.fn.glob(vimPlugPath)) == 1 then
	if vim.fn.isdirectory(autoloadDir) == 0 then
		vim.fn.mkdir(autoloadDir, 'p')
	end
	vim.fn.system('curl -fLo "'..vimPlugPath..'" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
	vim.cmd('source '..vimPlugPath)
	runPlugInstall = true
end

-- May help performance on some systems (maybe Windows).
--vim.opt.fsync = false

-- Set <Leader> and <LocalLeader> key binds for custom prefixing of keybinds
-- from plugins.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set to true if you have a Nerd Font installed and selected in the terminal
-- Some nerd fonts can be downloaded from https://www.nerdfonts.com/font-downloads
vim.g.have_nerd_font = true

vim.opt.encoding = "utf-8"

-- Setup line number column.
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.autowriteall = true
vim.opt.cursorline = true
vim.opt.foldenable = false
vim.opt.foldmethod = 'indent'

-- Set whitespace character visualization.
vim.opt.list = true
vim.opt.listchars:append({ space = '·' })

vim.opt.colorcolumn = "80,100"
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.tags = "./tags,tags;$HOME"

-- Line wrapping
vim.opt.wrap = true
vim.opt.breakindent = true

-- Settings for controlling indentation.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = false
vim.opt.confirm = true

-- Switching between previous and next split.
vim.keymap.set('n', '<C-l>', '<C-w>w', {})
vim.keymap.set('n', '<C-h>', '<C-w>W', {})

-- Switching between previous and next buffer in current split.
vim.keymap.set('n', '<C-PageUp>',   '<Cmd>bp<Enter>', {})
vim.keymap.set('n', '<C-PageDown>', '<Cmd>bn<Enter>', {})

-- Invoking :make command quickly.
vim.keymap.set('n', 'm', ':make<Enter>', {})

-- Close current buffer without closing window/split. Basically moves to
-- previous buffer, creates new split, returns to original buffer and closes
-- the split.
vim.keymap.set('n', '<C-q>', '<Cmd>bp<Bar>sp<Bar>bn<Bar>bd<Enter>', {})

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>')

-- Use `:PlugInstall` after adding a plugin to install it.
vim.call('plug#begin')

local Plug = vim.fn['plug#']
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.8' })
Plug('nvim-lualine/lualine.nvim')
Plug('ziglang/zig.vim')
Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('mason-org/mason.nvim')
Plug('mason-org/mason-lspconfig.nvim')
Plug('neovim/nvim-lspconfig')
Plug('nvimtools/none-ls.nvim')
Plug('Civitasv/cmake-tools.nvim')

vim.call('plug#end')
if runPlugInstall then
	vim.cmd('PlugInstall')
end

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, {})
vim.keymap.set('n', '<C-;>', telescope_builtin.current_buffer_fuzzy_find, {})
vim.keymap.set('n', '<C-r>', telescope_builtin.treesitter, {})

require('telescope').setup({})
require('lualine').setup({
	options = {
		theme = 'ayu_dark',
	},
})
require('nvim-treesitter.configs').setup({
	ensure_installed = {"c", "cpp", "lua", "rust", "zig"},
	highlight = { enable = true }
})
require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {
		'lua_ls',
		-- 'stylua',
	},
})
local null_ls = require('null-ls')
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
	}
})

vim.keymap.set('n', '<Leader>m', '<Cmd>CMakeBuild<Enter>')
vim.keymap.set('n', '<Leader>ccp', '<Cmd>CMakeSelectConfigurePreset<Enter>')
vim.keymap.set('n', '<Leader>cbp', '<Cmd>CMakeSelectBuildPreset<Enter>')

vim.lsp.enable('lua_ls')
vim.keymap.set('n', 'K', vim.lsp.buf.hover)
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gn', vim.lsp.buf.definition)
vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action)

-- vim.keymap.set('n', '<Leader>gf', vim.lsp.buf.format)
