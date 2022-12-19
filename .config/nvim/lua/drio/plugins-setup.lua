-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- add list of plugins to install
return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	-- Themes
	use("morhetz/gruvbox")
	use("marko-cerovac/material.nvim")
	use("VonHeikemen/rubber-themes.vim")
	use("folke/tokyonight.nvim")
	use("EdenEast/nightfox.nvim")
	use("bluz71/vim-nightfly-guicolors")

	use("ryanoasis/vim-devicons")
	-- We need this for icons in telescope
	use("kyazdani42/nvim-web-devicons")

	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- Alternative to find
	use("sharkdp/fd")

	-- completion
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-buffer") -- recommend from current buffer
	use("hrsh7th/cmp-path") -- recomment from the filepath
	use("hrsh7th/cmp-nvim-lua")

	-- managing & installing lsp servers, linters and formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	use("neovim/nvim-lspconfig") -- configure language servers to talk to the lsp implementation in neovim
	use("hrsh7th/cmp-nvim-lsp") -- link autocompletion and lsp
	use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind-nvim") -- vscode-like pictograms to neovim built-in lsp
	use({
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	})

	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				char = "┊",
				show_trailing_blankline_indent = false,
			})
		end,
	})

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- Snippets
	use("L3MON4D3/LuaSnip") -- nvim-cmp does not ship with snip plugin
	use("rafamadriz/friendly-snippets")

	-- https://mukeshsharma.dev/2022/02/08/neovim-workflow-for-terraform.html
	-- requires terraformls (language server), terraform (dah!) and tflint
	use("hashivim/vim-terraform") --

	use("hoob3rt/lualine.nvim")

	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
	})

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- install without yarn or npm
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	use("tpope/vim-dadbod")
	use("kristijanhusak/vim-dadbod-ui")
	use("tpope/vim-dotenv")

	use("gcmt/taboo.vim") -- change tab names

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	--use 'vimwiki/vimwiki'
	--use 'sheerun/vim-polyglot'
	use("tpope/vim-surround")

	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
			})
		end,
	})

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
