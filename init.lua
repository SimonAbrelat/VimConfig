-------------------------------------------------------------------------------------------------------------------------
-- General Settings
-------------------------------------------------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- history
vim.g.history = 500

-------------------------------------------------------------------------------------------------------------------------
-- Installing Packages
-------------------------------------------------------------------------------------------------------------------------
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
		  },
	  }
})

-------------------------------------------------------------------------------------------------------------------------
-- FUGITIVE
-------------------------------------------------------------------------------------------------------------------------
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-------------------------------------------------------------------------------------------------------------------------
-- LSP CONFIG
-------------------------------------------------------------------------------------------------------------------------
local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = 'LSP: ' .. desc
		end

		vim.keymap.set('n', keys, func, {buffer = bufnr, desc=desc })
	end

	local servers = {
		clangd = {},
		pylsp = {},
		rust_analyzer = {},
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
end

-------------------------------------------------------------------------------------------------------------------------
-- TELESCOPE
-------------------------------------------------------------------------------------------------------------------------
local builtin = require('telescope.builtin')
vim.keymap.set('n', "<leader>ff", builtin.find_files, {});
vim.keymap.set('n', "<leader>fg", builtin.git_files, {});
vim.keymap.set('n', "<leader>fs", function() 
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end);

-------------------------------------------------------------------------------------------------------------------------
-- TREESITTER
-------------------------------------------------------------------------------------------------------------------------
require'nvim-treesitter.configs'.setup {
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
	textobbjects = {
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
}


