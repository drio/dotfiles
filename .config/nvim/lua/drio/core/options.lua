--[[
  https://github.com/josean-dev/dev-environment-files/tree/main/.config/nvim
  https://github.com/nanotee/nvim-lua-guide
  https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
  https://github.com/VonHeikemen/dotfiles/tree/master/my-configs/neovim
  https://learnxinyminutes.com/docs/lua/
  https://www.notonlycode.org/neovim-lua-config/
--]]
local set = vim.opt

set.timeoutlen=500 -- Assuming you have two mappings: gc and gcc, when you pressed gc and stopped, 
                   -- vim would wait timeoutlen to see if you want to trigger gc or just in the middle of gcc.
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
set.relativenumber = true
set.number = true
set.signcolumn = "yes"
set.clipboard:append("unnamedplus") -- use system clipboard as default register
set.iskeyword:append("-")
set.splitright = true -- split vertical window to the right
set.splitbelow = true -- split horizontal window to the bottom
set.wildmenu = true
set.wildignore = vim.opt.wildignore + '*.so,*.swp,*.zip,*.pyc'
vim.opt.listchars = {
  eol = 'x',
  tab = '>-',
  trail = '⚠',
  extends = '>',
  precedes = '▶',
--  space = '❤',
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
-- This is necessary for pasting properly from the clipboard
vim.cmd([[
filetype plugin indent on
]])



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
set.sessionoptions:append("tabpages,globals")

-- disable sql completion (very annoying)
vim.g.loaded_sql_completion = 0
vim.g.omni_sql_no_default_maps = 1
