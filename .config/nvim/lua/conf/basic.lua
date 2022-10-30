--[[
  https://github.com/nanotee/nvim-lua-guide
  https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
  https://github.com/VonHeikemen/dotfiles/tree/master/my-configs/neovim
  https://learnxinyminutes.com/docs/lua/
  https://www.notonlycode.org/neovim-lua-config/
--]]
--require('nvim_comment').setup()

--local cwd = vim.fn.getcwd()
--local f = string.format
local set = vim.opt

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'


vim.cmd([[
" file type detection for plugins and indentation
" Do we need it?
"filetype plugin indent on 
]])

-- Assuming you have two mappings: gc and gcc, when you pressed gc and stopped, 
-- vim would wait timeoutlen to see if you want to trigger gc or just in the middle of gcc.
set.timeoutlen=500
set.wrap = false
set.expandtab = true
set.encoding = 'UTF-8'
set.showcmd = true
set.modelines = 3
set.tabstop = 2
set.shiftwidth = 2
set.hlsearch = true
set.incsearch = true
set.ignorecase = true
set.smartcase = true
set.hidden = true
set.showmatch = true
set.number = true
set.wildmenu = true
set.wildignore = vim.opt.wildignore + '*.so,*.swp,*.zip,*.pyc'
-- set.listchars = 'tab:>-,trail:-'
vim.opt.listchars = {
  eol = 'x',
  tab = '>-',
  trail = '⚠',
--  space = '❤',
  extends = '>',
  precedes = '▶',
}

set.list = false
set.shortmess = vim.opt.shortmess + 'c'
set.scrolloff = 2
set.sidescrolloff = 2
set.foldmethod='indent'
set.foldlevel=1
set.cursorline=true
set.laststatus=1
set.paste = true

-- set.winbar="%f" -- show the name of the file on each window
-- vim.o.ls = 0 -- no last status
-- vim.o.ch = 0 -- command height

--[[ 
In insert mode, if you have typed a word which Vim thinks is miss-spelled, an
underline is shown below. To correct this error, press <C-x> followed by s.

In normal mode, to navigate between possible spell errors, use the following shortcut:
  [s: go to previous spell error
  ]s: go to next spell error

If you think a word is not a spell error, you can use zg to add it to your spell file.

To correct an error, press z=

Or you may use 1z= to choose the first candidate directly
--]]
set.spelllang="en_us"
-- set.spell=true


set.termguicolors = true
-- disable netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- disable sql completion (very annoying)
vim.g.loaded_sql_completion = 0
vim.g.omni_sql_no_default_maps = 1

-- vim.cmd 'colorscheme NeoSolarized'
--
-- vim.g['gruvbox_contrast_dark'] = 'low'
--
-- vim.g.material_style = "oceanic"
--
vim.cmd 'colorscheme material'
-- vim.cmd [[colorscheme nightfly]]
--
-- vim.g.material_style = "palenight"
-- vim.g.material_style = "oceanic"
--
-- vim.cmd 'colorscheme rubber-enhanced'
-- vim.cmd[[colorscheme tokyonight]]
--
-- vim.cmd("colorscheme nightfox")


-- When loading the telescope window, disable paste to avoid issues
vim.api.nvim_create_autocmd("user TelescopePreviewerLoaded", { command = "set nopaste" })

-- Plugin specific configuration
vim.cmd([[
" VimWiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" to save tab names (taboo) when saving session
set sessionoptions+=tabpages,globals
]])

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  sync_root_with_cwd = true,
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  remove_keymaps = false,
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
