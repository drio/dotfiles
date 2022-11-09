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
  use 'wbthomason/packer.nvim'

  -- Themes
  use 'morhetz/gruvbox'
  use 'marko-cerovac/material.nvim'
  use 'VonHeikemen/rubber-themes.vim'
  use 'folke/tokyonight.nvim'
  use "EdenEast/nightfox.nvim"
  use 'bluz71/vim-nightfly-guicolors'

  use 'ryanoasis/vim-devicons'
  -- We need this for icons in telescope
  use 'kyazdani42/nvim-web-devicons'

  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  -- NOTE on treesitter: You have to install parsers for each language.
  -- For example, you can install JavaScript parser with:
  -- TSInstall javascript

  use 'neovim/nvim-lspconfig'
  use 'sharkdp/fd'

  -- completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'    -- recommend from current buffer
  use 'hrsh7th/cmp-path'      -- recomment from the filepath
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'

  -- Snippets
  use 'L3MON4D3/LuaSnip' -- nvim-cmp does not ship with snip plugin
  use "onsails/lspkind-nvim" -- vscode-like pictograms to neovim built-in lsp
  use 'rafamadriz/friendly-snippets'

  -- https://mukeshsharma.dev/2022/02/08/neovim-workflow-for-terraform.html
  -- requires terraformls (language server), terraform (dah!) and tflint
  use 'hashivim/vim-terraform' --

  use 'hoob3rt/lualine.nvim'
  -- use { 'scrooloose/nerdtree', on = 'NERDTreeToggle' }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  }

  -- Notice we also want the lsp client loaded. It seems necessary. Why?
  -- So, enable svelte in the lsp setup please.
  use 'othree/html5.vim'
  use 'pangloss/vim-javascript'
  use 'evanleck/vim-svelte'
  -- we need it to format other things like css etc...
  -- not completely sure who is doing what (lsp, completion, prettier, vim-svelte)
  -- use 'prettier/vim-prettier'
  --[[
  -- A few plugins play a role in having syntax highlight an conmpletion for svelte:
  -- lsp building
  -- vim-svelte
  -- vim-prettier
  --]]

  use 'ThePrimeagen/vim-be-good'

  -- install without yarn or npm
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- go until I get gopls work directly with neovim's lsp
  -- use 'fatih/vim-go'
  -- use 'ray-x/go.nvim'


  use 'tpope/vim-dadbod'
  use 'kristijanhusak/vim-dadbod-ui'
  use 'tpope/vim-dotenv'

  use 'gcmt/taboo.vim' -- change tab names

  --use 'vim-scripts/dbext.vim' -- necssesary for sql completion

  --use ''
  --use 'terrortylor/nvim-comment'
  use {
    'numToStr/Comment.nvim', config = function()
      require('Comment').setup()
    end
  }

  --use 'vimwiki/vimwiki'
  --use 'sheerun/vim-polyglot'
  use 'tpope/vim-surround'

  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup() end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end
  }


  if packer_bootstrap then
    require("packer").sync()
  end
end)
