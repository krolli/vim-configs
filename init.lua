-- https://blog.nikfp.com/how-to-install-and-set-up-neovim-on-windows
-- :h lua-guide

-- May help performance on some systems (maybe Windows).
--vim.opt.fsync = false

-- Set <Leader> and <LocalLeader> key binds for custom prefixing of keybinds
-- from plugins.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set to true if you have a Nerd Font installed and selected in the terminal
-- Some nerd fonts can be downloaded from https://www.nerdfonts.com/font-downloads
vim.g.have_nerd_font = true

vim.g.markdown_recommended_style = false

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
vim.opt.listchars:append({ space = '·', nbsp = '␣' })

vim.opt.colorcolumn = "80,100"
vim.opt.signcolumn = 'yes'
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
-- Dealing with annoying indentation of C preprocessor code. Details in `:h indent.txt`
-- vimscript: `:set cinkeys-=0#`
-- vimscript: `:set cinoptions+=#1s`
-- Needs to be investigated more, though these seem like good defaults.
-- Not sure I want this everywhere or just some projects. Currently setting in
-- Session.vim to restrict behavior.
-- Generally want to restrict to just C/C++ files. Since these options are
-- designed for C-like languages, it might be safe to set globally.

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

local function init_diagnostic()
	vim.diagnostic.config({
		float = { border = 'rounded', source = 'if_many' },
		underline = { severity = vim.diagnostic.severity.ERROR },
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = '󰅚',
				[vim.diagnostic.severity.WARN] = '󰀪',
				[vim.diagnostic.severity.INFO] = '󰋽',
				[vim.diagnostic.severity.HINT] = '󰌶',
			},
		},
		virtual_text = false,
	})
	local vt_table = {
		source = 'if_many',
		spacing = 2,
	}
	local vt_enabled = false
	local function toggle_vt()
		if vt_enabled then
			vim.diagnostic.config({ virtual_text = false })
		else
			vim.diagnostic.config({ virtual_text = vt_table })
		end
		vt_enabled = not vt_enabled
	end
	vim.keymap.set('n', '<Leader>td', toggle_vt, { desc = '[t]oggle [d]iagnostic virtual text' })
end

init_diagnostic()

vim.filetype.add({
	extension = {
		Jenkinsfile = 'groovy',
		Containerfile = 'dockerfile',
	}
})

vim.pack.add{
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/nvim-lualine/lualine.nvim',
	'https://codeberg.org/ziglang/zig.vim',
	'https://github.com/nvim-tree/nvim-web-devicons',
	'https://github.com/nvim-treesitter/nvim-treesitter',-- { ['do'] = ':TSUpdate' }),
	'https://github.com/mason-org/mason.nvim',
	'https://github.com/mason-org/mason-lspconfig.nvim',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/nvimtools/none-ls.nvim',
	'https://github.com/folke/which-key.nvim',
}

local function init_telescope()
	require('telescope').setup({})
	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<Leader>fc', builtin.current_buffer_fuzzy_find, { desc = '[f]ind in [c]urrent buffer' })
	vim.keymap.set('n', '<Leader>ft', builtin.treesitter, { desc = '[f]ind using [t]reesitter' })
	vim.keymap.set('n', '<Leader>fh', builtin.help_tags, { desc = '[f]ind in [h]elp' })
	vim.keymap.set('n', '<Leader>fk', builtin.keymaps, { desc = '[f]ind [k]eymaps' })
	vim.keymap.set('n', '<Leader>ff', builtin.find_files, { desc = '[f]ind [f]iles' })
	vim.keymap.set('n', '<Leader>fb', builtin.builtin, { desc = '[f]ind [b]uilt-in Telescope picker' })
	vim.keymap.set('n', '<Leader>fw', builtin.grep_string, { desc = '[f]ind [w]ord under cursor' })
	vim.keymap.set('n', '<Leader>fg', builtin.live_grep, { desc = '[f]ind by [g]rep' })
	vim.keymap.set('n', '<Leader>fd', builtin.diagnostics, { desc = '[f]ind in [d]iagnostics' })
	vim.keymap.set('n', '<Leader>fp', builtin.resume, { desc = '[f]ind (resume [p]revious)' })
	vim.keymap.set('n', '<Leader>f.', builtin.oldfiles, { desc = '[f]ind in recent files ([.] for repeat)' })
	vim.keymap.set('n', '<Leader>fo', builtin.buffers, { desc = '[f]ind [o]pen buffer' })
end

init_telescope()

require('which-key').setup({
	delay = 1000,
	icons = {
		mappings = vim.g.have_nerd_font,
		keys = {},
	},
	spec = {
		{ '<Leader>f', group = '[f]ind ...' },
		{ '<Leader>g', group = '[g]o to ...' },
		{ '<Leader>c', group = '[c]ode ...' },
		{ '<Leader>t', group = '[t]oggle' },
	},
})

require('lualine').setup({
	options = {
		theme = 'ayu_dark',
	},
})

-- It is possible to view treesitter parse tree of a buffer using commands :Inspect and :InspectTree
require('nvim-treesitter').setup({
	ensure_installed = {
		"c",
		"cpp",
		"cmake",
		"go",
		-- "lua",
		"rust",
		"zig",
	},
	highlight = { enable = true }
})
require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = {
		'lua_ls',
		-- 'stylua',
		'clangd',
		'gopls',
	},
})

vim.lsp.enable('lua_ls')
vim.lsp.config('lua_ls', {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				version = 'LuaJIT',
				path = {
					'lua/?.lua',
					'lua/?/init.lua',
				},
			},
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME,
					'${3rd}/luv/library',
				}
			}
		})
	end,
	settings = {
		Lua = {}
	}
})
vim.lsp.enable('clangd')
-- vim.lsp.config('clangd', {
-- 	settings = {
-- 	}
-- })
vim.lsp.enable('gopls')

local augid = vim.api.nvim_create_augroup("MyVimRC", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = augid,
	pattern = "lilypond",
	callback = function()
		vim.opt_local.shiftwidth = 4
	end
})
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or 'n'
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
		end

		local telescope = require('telescope.builtin')
		local function find_references()
			telescope.lsp_references { show_line = false }
		end
		map('<Leader>ch', vim.lsp.buf.hover, '[c]ode [h]over')
		map('<Leader>cr', vim.lsp.buf.rename, '[c]ode [r]ename')
		map('<Leader>ca', vim.lsp.buf.code_action, '[c]ode [a]ction', { 'n', 'x' })
		map('<Leader>cf', vim.lsp.buf.format, '[c]ode [f]ormat')
		map('<Leader>gi', telescope.lsp_implementations, '[g]o to [i]mplementation')
		map('<Leader>gd', telescope.lsp_definitions, '[g]o to [d]efinition') --  To jump back, press <C-t>.
		map('<Leader>gD', vim.lsp.buf.declaration, '[g]o to [D]eclaration')
		map('<Leader>gt', telescope.lsp_type_definitions, '[g]o to [t]ype of symbol')
		map('<Leader>fr', find_references, '[f]ind [r]eferences')
		map('<Leader>fs', telescope.lsp_document_symbols, '[f]ind document [s]ymbols')
		map('<Leader>fS', telescope.lsp_dynamic_workspace_symbols, '[f]ind workspace [S]ymbols')

		-- The following two autocommands are used to highlight references of the
		-- word under your cursor when your cursor rests there for a little while.
		--    See `:help CursorHold` for information about when this is executed
		--
		-- When you move your cursor, the highlights will be cleared (the second autocommand).
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
			vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd('LspDetach', {
				group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
				end,
			})
		end

		local function toggle_inlay_hints()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
		end
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
			map('<Leader>th', toggle_inlay_hints, '[t]oggle inlay [h]ints')
		end
	end,
})
