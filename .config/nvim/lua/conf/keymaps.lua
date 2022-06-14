--[[
If you run into issues where a mapping is not working as expected use:

:map
:nmap for normal mode mappings
:vmap for visual mode mappings
:imap for insert mode mappings

To find out what plugin is attached to that mapping
--]]

local map = function(key)
  -- get the extra options
  local opts = {noremap = true}
  for i, v in pairs(key) do
    if type(i) == 'string' then opts[i] = v end
  end

  -- basic support for buffer-scoped keybindings
  local buffer = opts.buffer
  opts.buffer = nil

  if buffer then
    vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
  else
    vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
  end
end

local bind = vim.api.nvim_set_keymap
--local remap = function(m, lhs, rhs) bind(m, lhs, rhs, {noremap = false}) end
local noremap = function(m, lhs, rhs) bind(m, lhs, rhs, {noremap = true}) end


-- mode, key, action, extra
map {'n', '<SPACE>', '<Nop>'}
map {'', '<C-h>', '<C-w>h'}
map {'', '<C-j>', '<C-w>j'}
map {'', '<C-k>', '<C-w>k'}
map {'', '<C-l>', '<C-w>l'}

-- tabs
map {'n', '<leader>1', '1gt'}
map {'n', '<leader>2', '2gt'}
map {'n', '<leader>3', '3gt'}
map {'n', '<leader>4', '4gt'}
map {'n', '<leader>5', '5gt'}
map {'n', '<leader>6', '6gt'}

noremap('n', '<leader><leader>q', ':qa!<CR>')

-- Switch to the directory of the open buffer
noremap('n', '<Leader>cd', ':lcd %:p:h<CR>:pwd<CR>')

-- TODO tons of other maps
vim.cmd([[
" ------------------------  Maps
nnoremap <leader>e :w<CR>
" Quit highlight
nnoremap <leader>q :nohlsearch<CR>
nnoremap <leader>l :set list!<CR>
" Cycle to previous buffer
nnoremap <leader>v <c-^>
nnoremap <leader>V :e $MYVIMRC<CR>

" Show special characters
nnoremap <leader>Y :let @a='- \[\[' . expand("%:t") . '\]\]' <CR>
nnoremap <leader>P <C-c>"ap
nnoremap <leader><leader>p :w !pbcopy<cr><cr>
vnoremap <leader>y :w !pbcopy<cr><cr>



" signs/linenumber
noremap <leader>un :windo execute ':set nonu norelativenumber'<CR>
noremap <leader>uy :windo execute ':set number'<CR>
noremap <leader>ur :windo execute ':set relativenumber'<CR>
noremap <leader>us :set scl=yes<CR>
noremap <leader>ud :set scl=no<CR>
noremap <leader>uh :set scl=no \| set nonu norelativenumber<CR>
noremap <leader>uH :set scl=yes \| set relativenumber<CR>

" SPLITS
noremap <leader>sc :close<CR>
noremap <leader>sh :sp<CR>
noremap <leader>sv :vsp<CR>
" Open file under the cursor
noremap <leader>sg <c-w>f<c-w>L
noremap <leader>so :only<CR>

" SPELL (tofix)
"nnoremap <leader>sp :set spell!<CR>
"nnoremap <leader>sf 1z=
"map <Leader>se :setlocal spell spelllang=es_es<CR>
"map <Leader>ss :setlocal spell spelllang=en_us<CR>

" --- Telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Open a file with gf even if it doesn't exist
map gf :edit <cfile><cr>

" Resize even
map <leader>E <C-w>=leader>E <C-w>=

" After nvim 0.6.0 YP did not do what I expected
map YP yyp

" Keep the cursor at the center of the screen when scrolling
"nnoremap J jzz
"nnoremap K kzz "

" map <leader>x :execute getline(".")<CR>

" Presentation mode
" nmap <silent> <leader><leader>p :set norelativenumber nonumber noshowmode noshowcmd nohidden noruler scl=no laststatus=0<CR>
" nmap <silent> <leader><leader>P :set number showmode showcmd hidden ruler scl=yes laststatus=2<CR>
]])

