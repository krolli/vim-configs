-- :h lua-guide

vim.cmd([[
    let data_dir = stdpath('data') . '/site'
    if empty(glob(data_dir . '/autoload/plug.vim'))
        silent execute '!curl -fLo "'.data_dir.'/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
     endif
]])
local luv = vim.uv or vim.loop
local data_dir = vim.fn.stdpath('data') .. '/site/autoload'
if not luv.fs_stat(data_dir) then
    vim.fn.system('mkdir "' .. data_dir .. '"')
end
if not luv.fs_stat(data_dir .. '/plug.vim') then
    vim.fn.system('curl -fLo "' .. data_dir .. '/plug.vim" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    vim.api.nvim_create_autocmd("VimEnter", {
        pattern = "*",
        command = "PlugInstall --sync | source $MYVIMRC",
    })
end

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

vim.opt.encoding = "utf-8"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autowriteall = true
vim.opt.cursorline = true
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
    pattern = "*.Jenkinsfile",
    command = "set syntax=groovy",
})
vim.opt.foldmethod = 'indent'
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
vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.confirm = true

-- Switching between previous and next split.
vim.keymap.set('n', '<C-l>', '<C-w>w', {})
vim.keymap.set('n', '<C-h>', '<C-w>W', {})
vim.keymap.set('n', '<M-Right>', '<C-w>w', {})
vim.keymap.set('n', '<M-Left>', '<C-w>W', {})
-- Switching between previous and next buffer in current split.
vim.keymap.set('n', '<C-PageUp>', ':bp<Enter>', {})
vim.keymap.set('n', '<C-PageDown>', ':bn<Enter>', {})
-- Jumping to previous and next empty line (paragraphs).
vim.keymap.set('n', '<C-Up>', '{', {})
vim.keymap.set('n', '<C-Down>', '}', {})
vim.keymap.set('n', 'm', ':make<Enter>', {})
-- Close current buffer without closing window/split. Basically moves to
-- previous buffer, creates new split, returns to original buffer and closes
-- the split.
vim.keymap.set('n', '<C-q>', ':bp<bar>sp<bar>bn<bar>bd<Enter>', {})

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Use `:PlugInstall` after adding a plugin to install it.
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.8' })
Plug('nvim-lualine/lualine.nvim')
Plug('ziglang/zig.vim')
Plug('nvim-tree/nvim-web-devicons')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('mason-org/mason.nvim')
vim.call('plug#end')

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, {})

require('lualine').setup({
    options = {
        theme = 'ayu_dark',
    },
})
require('nvim-treesitter.configs').setup({
    highlight = { enable = true }
})
require('mason').setup()
