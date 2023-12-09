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
	{import = "user.nvim-tree"},
	{import = "user.lualine"},
	{import = "user.lsp"},
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
})

require('mason').setup()
require('mason-lspconfig').setup()
