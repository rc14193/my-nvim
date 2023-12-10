require "config.keymaps"
require "config.themes"

-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	-- NOTE: This is where your plugins related to LSP can be installed.
	--  The configuration is done below. Search for lspconfig to find it below.
	{
		-- LSP Configuration & Plugins
	    	'neovim/nvim-lspconfig',
	    dependencies = {
		-- Automatically install LSPs to stdpath for neovim
	      	'williamboman/mason.nvim',
	      	'williamboman/mason-lspconfig.nvim',

	      	-- Useful status updates for LSP
	      	-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
	      	{ 'j-hui/fidget.nvim', opts = {} },

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
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

	{import = "user.nvim-tree"},
	{import = "user.lualine"},
	{import = "user.lsp"},
	{import = "user.git"},
})

