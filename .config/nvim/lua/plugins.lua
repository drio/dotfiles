vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
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
  -- connect the completion engine to other subsystems (like lsp)
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip' -- nvim-cmp does not ship with snip plugin
  use "onsails/lspkind-nvim" -- vscode-like pictograms to neovim built-in lsp
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

  --use 'sbdchd/neoformat'
  use 'terrortylor/nvim-comment'

  --use 'vimwiki/vimwiki'
  --use 'sheerun/vim-polyglot'
  --use 'tpope/vim-surround'

  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup() end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end
  }

end)
