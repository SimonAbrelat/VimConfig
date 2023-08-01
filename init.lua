------------------------------------------------------------------------------
-- General Settings
------------------------------------------------------------------------------
-- history
vim.g.history = 500
-- line numbering
vim.opt.number = true
vim.opt.relativenumber = true
-- tabbing
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
-- file backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true
-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true
-- colors
vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"
-- file end
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
-- nice cursor
vim.opt.cursorline = true
vim.opt.ruler = true
vim.cmd([[
set guicursor=
augroup CustomCursorLine
    au!
    au ColorScheme * :hi clear CursorLine
    au ColorScheme * :hi! CursorLine gui=underline cterm=underline
augroup END
]])


------------------------------------------------------------------------------
-- Remaps
------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>fv", vim.cmd.Ex)

-- scope aware moves
vim.keymap.set('v', "J", ":m '>+1<CR>gv=gv")
vim.keymap.set('v', "K", ":m '<-2<CR>gv=gv")
-- center the screen
vim.keymap.set('n', "<C-d>", "<C-d>zz")
vim.keymap.set('n', "<C-u>", "<C-u>zz")
vim.keymap.set('n', "n", "nzzzv")
vim.keymap.set('n', "N", "Nzzzv")

-- better yanks and pastes
vim.keymap.set('n', "<leader>p", "\"_dP",
    { desc = "Do not override paste buffer" }
)
vim.keymap.set({'n', 'v'}, "<leader>y", "\"+y",
    { desc = "Yank to clipboard" }
)
vim.keymap.set('v', "<leader>Y", "\"+Y")

vim.keymap.set({'n', 'v'}, "<leader>d", "\"_d",
    { desc = "Delete without override paste buffer" }
)

vim.keymap.set("n", "Q", "<Nop>")
vim.keymap.set("n", "<leader>vf", function()
    vim.lsp.buf.format()
end, { desc = "Format code" })

-- window operations
vim.keymap.set('n', "<leader>wv", "<C-w>v", { desc = "[W]indow split [v]ertically" })
vim.keymap.set('n', "<leader>ws", "<C-w>s", { desc = "[W]indow [s]plit horizontally" })
vim.keymap.set('n', "<leader>wh", "<C-w>h", { desc = "[W]indow switch left" })
vim.keymap.set('n', "<leader>wj", "<C-w>j", { desc = "[W]indow switch down" })
vim.keymap.set('n', "<leader>wk", "<C-w>k", { desc = "[W]indow switch up" })
vim.keymap.set('n', "<leader>wl", "<C-w>l", { desc = "[W]indow switch right" })
vim.keymap.set('n', "<leader>wc", "<C-w>c", { desc = "[W]indow [c]lose" })
vim.keymap.set('n', "<leader>ww", "<cmd>w<CR>", { desc = "Window [w]rite" })
vim.keymap.set('n', "<leader>wq", "<cmd>q<CR>", { desc = "[W]indow [q]uit" })

-- tab operations
for i=1,9 do
    vim.keymap.set({'n', 'v'}, "<leader>t" .. i, i .. "gt", { desc = "Switch to [T]ab [" .. i .. "]"})
end
vim.keymap.set('n', "<leader>tw", "<C-w>T", { desc = "Open new [t]ab with [w]indow" })
vim.keymap.set('n', "<leader>tn", "<cmd>tabnew<Cr>", { desc = "[T]ab [N]ew" })
vim.keymap.set('n', "<leader>tc", "<cmd>tabc<Cr>", { desc = "Current [T]ab [C]lose" })


-- exit the terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

------------------------------------------------------------------------------
-- Installing Packages
------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	},
	{
		'nvim-telescope/telescope.nvim',
		branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
			vim.cmd('colorscheme rose-pine')
		end
	},
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		build = ':TSUpdate',
	},
	{
		'tpope/vim-fugitive'
	},

	{
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ 'williamboman/mason.nvim', config = true },
			'williamboman/mason-lspconfig.nvim',

			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

			-- Additional lua configuration, makes nvim stuff amazing!
			'folke/neodev.nvim',
		},
	},
	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			'L3MON4D3/LuaSnip',
			'saadparwaiz1/cmp_luasnip',

			-- Adds LSP completion capabilities
			'hrsh7th/cmp-nvim-lsp',

			-- Adds some user-friendly snippets
			'rafamadriz/friendly-snippets',
		},
	},
	{
		-- Make a pretty line
		'nvim-lualine/lualine.nvim',
	},
}, {})

------------------------------------------------------------------------------
-- FUGITIVE
------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

------------------------------------------------------------------------------
-- Lualine
------------------------------------------------------------------------------
require('lualine').setup({
    options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
    },
})

------------------------------------------------------------------------------
-- LSP CONFIG
------------------------------------------------------------------------------
local on_attach = function(_, bufnr)
	local map = function(mode, keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set(mode, keys, func, {buffer = bufnr, desc=desc, remap = false})
	end

	map('n', 'gd', function () vim.lsp.buf.definition() end, "Goto Definition")
	map('n', 'K', function () vim.lsp.buf.hover() end, "Definition Hover")
	map('n', '<leader>ls', function () vim.lsp.buf.workspace_symbol() end, "[L]SP Workspace [S]ymbol")
	map('n', '<leader>ld', function () vim.diagnostic.open_float() end, "[L]SP [D]iagnostic")
	map('n', '[d', function () vim.diagnostic.goto_next() end, "Next Diagnostic")
	map('n', ']d', function () vim.diagnostic.goto_prev() end, "Previous Diagnostic")
	map('n', '<leader>la', function () vim.lsp.buf.code_action() end, "[L]SP code [a]ctopn")
	map('n', '<leader>lr', function () vim.lsp.buf.references() end, "[L]SP goto [r]eference")
	map('n', '<leader>ln', function () vim.lsp.buf.rename() end, "[L]SP re[n]ame")
	map('i', '<C-h>', function () vim.lsp.buf.signature_help() end, "Help with signature")
end

-- Define required servers
local servers = {
	clangd = {},
	pylsp = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		}
	},
}

require('neodev').setup()

-- nvim-cmp supports 
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the server above are installed
local mason_lspconfig = require('mason-lspconfig')

mason_lspconfig.setup({
	ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
	function(server_name)
		require('lspconfig')[server_name].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name]
		})
	end,
})

-- [[ Configure nvim-cmp ]]
local cmp = require('cmp')
local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup({})

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete({}),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				cmp.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_previous_item()
			elseif luasnip.expand_or_locally_jumpable() then
				cmp.expand_or_jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	},
})

------------------------------------------------------------------------------
-- TELESCOPE
------------------------------------------------------------------------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', "<leader>ff", builtin.find_files, { desc = "Find files" });
vim.keymap.set('n', "<leader>fg", builtin.git_files, { desc = "Find files using git"});
vim.keymap.set('n', "<leader>fs", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Find files containing string"});

------------------------------------------------------------------------------
-- TREESITTER
------------------------------------------------------------------------------
require('nvim-treesitter.configs').setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = { "c", "cpp", "python", "lua"},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,
	highlight = { enable = true, },
	index = { enable = true, },
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<c-space>",
			node_selection = "<c-space>",
			scope_selection = "<c-s>",
			--node_decremental = "<c-shift-space>",
		},
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to text object
			keymaps = {
				['aa'] = "@paramter.outer",
				['ia'] = "@paramter.inner",
				['af'] = "@function.outer",
				['if'] = "@function.inner",
				['ac'] = "@class.outer",
				['ic'] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				[']m'] = "@function.outer",
				[']]'] = "@class.outer",
			},
			goto_next_end= {
				[']M'] = "@function.outer",
				[']['] = "@class.outer",
			},
			goto_previous_start = {
				['[m'] = "@function.outer",
				['[['] = "@class.outer",
			},
			goto_previous_end = {
				['[M'] = "@function.outer",
				['[]'] = "@class.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				['<leader>a'] = '@parameter.inner',
			},
			swap_previous = {
				['<leader>A'] = '@parameter.inner',
			},
		}
	}
})
