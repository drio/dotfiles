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
set.laststatus=3

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

vim.cmd 'set nofoldenable'

if vim.fn.has('termguicolors') == 1 then
  set.termguicolors = true
end
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- disable sql completion (very annoying)
vim.g.loaded_sql_completion = 0
vim.g.omni_sql_no_default_maps = 1

-- vim.cmd 'colorscheme NeoSolarized'
--
-- vim.g['gruvbox_contrast_dark'] = 'low'
--
-- vim.g.material_style = "oceanic"
vim.cmd 'colorscheme material'
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
" NerdTREE
noremap <silent> <leader>nt :NERDTreeToggle<CR>
" Set the directory of the current file as current dir for NERDtree
noremap <leader>nf :NERDTreeFind<cr>
let NERDTreeIgnore=['\.pyc$', '__pycache__']


" Prettier Settings
"let g:prettier#autoformat = 0
"let g:prettier#quickfix_enabled = 0
"let g:prettier#autoformat_require_pragma = 0
"au BufWritePre *.css,*.svelte,*.pcss,*.html,*.ts,*.js,*.json PrettierAsync

" ----------------------- END Maps

" VimWiki
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

"""
" Save sessions on exit and make it work with nerdtree
" Close NERDTree when leaving vim so we don't have issues saving session
autocmd VimLeave * NERDTreeClose
" autocmd VimLeave * mksession!
" to save tab names (taboo) when saving session
set sessionoptions+=tabpages,globals
"""

]])
