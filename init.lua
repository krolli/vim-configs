-- :h lua-guide

vim.cmd([[
  let data_dir = stdpath('data') . '/site'
  if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
]])

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.encoding = "utf-8"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autowriteall = true
vim.opt.cursorline = true
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "*.Jenkinsfile",
  command = "set syntax=groovy",
})
vim.opt.foldmethod = 'syntax'
vim.opt.list = true
vim.opt.listchars:append({ space = '·' })
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.colorcolumn = "80,100"
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

local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', { tag = '0.1.8' })
Plug('nvim-lualine/lualine.nvim')
Plug('ziglang/zig.vim')
Plug('nvim-tree/nvim-web-devicons')
vim.call('plug#end')

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', telescope_builtin.find_files, {})

require('lualine').setup({
  options = {
    theme = 'ayu_dark',
  },
})

