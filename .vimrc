set nocompatible
filetype off

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'ryanoasis/vim-devicons'
Plug 'kien/ctrlp.vim'

Plug 'pangloss/vim-javascript'    
Plug 'maxmellon/vim-jsx-pretty' 
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'vimwiki/vimwiki'
Plug 'gcmt/taboo.vim'
"Plug 'wincent/terminus'

Plug 'sudar/vim-arduino-syntax'

Plug 'morhetz/gruvbox'

call plug#end()

filetype plugin indent on       " load file type plugins + indentation

set nonu
set encoding=UTF-8
set showcmd                     " display incomplete commands
set foldmethod=indent
set foldlevelstart=0
set showcmd                     " to see partial commands as you type them
set modelines=3
set wrap                      " don't wrap lines
set tabstop=2 shiftwidth=2 et   " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set hidden                      " Hide the buffer when switching to another, don't try to save it
set nocursorline
set spelllang=en_us
set listchars=tab:▸-,space:x,eol:X,trail:·,nbsp:_
set laststatus=2                " Always show the statusline
set runtimepath^=~/.vim/bundle/ctrlp.vim
set rtp+=/usr/local/go/misc/vim
set noerrorbells
set novisualbell
let c_minlines=500
set nofoldenable
set nostartofline
set showmatch
"set viminfo='100,n$HOME/.vim/files/info/viminfo
set t_Co=256
set backupdir=~/.vim.backup/
set dir=~/.vim.swp/,/var/tmp/,/tmp/,.  " Store swp files in a specific location
set expandtab
"set paste
set number
set wildmenu
set wildignore+=*.so,*.swp,*.zip,*.pyc
"set wildmode=longest,list,full
set wildmode=full
set sessionoptions+=tabpages,globals
"set relativenumber

" Maps
let mapleader=' '
let maplocalleader='\\'
"let mapleader='\'
"let maplocalleader='\\'


" Source Vim configuration file and install plugins
nnoremap <silent><leader>1 :source ~/.vimrc \| :PlugInstall<CR>

" To check for ambiguities: " :verbose noremap <leader>b
nnoremap <space> ;
nnoremap <leader>ev :e $MYVIMRC<CR>

noremap <leader><leader>q :qa!<CR>
" Cycle to previous buffer nnoremap <leader><leader> <c-^>
nnoremap <leader>f <c-^>

noremap <leader>un :windo execute ':set nonu norelativenumber'<CR>
noremap <leader>uy :windo execute ':set number'<CR>
noremap <leader>ur :windo execute ':set relativenumber'<CR>
noremap <leader>us :set scl=yes<CR>
noremap <leader>ud :set scl=no<CR>
noremap <leader>uh :set scl=no \| set nonu norelativenumber<CR>
noremap <leader>uH :set scl=yes \| set number<CR>

" Window spliting
noremap <leader>sc :close<CR>
noremap <leader>sh :sp<CR>
noremap <leader>sv :vsp<CR>
" http://vim.wikia.com/wiki/Open_file_under_cursor
noremap <leader>sg <c-w>f<c-w>L
noremap <leader>so :only<CR>

nnoremap <leader>q :nohlsearch<CR>
nnoremap <leader>l :set list!<CR>

" Change working dir to dir in current file
nnoremap <leader>p :cd %:h<CR>

nnoremap <leader><leader>w :set wrap!<CR>

" For when the redering fails:
" noremap <leader>r :CocRestart<CR>

noremap <silent> <leader>nt :NERDTreeToggle<CR>
" Set the directory of the current file as current dir for NERDtree
noremap <leader>nf :NERDTreeFind<cr>
noremap <leader>vu :BundleUpdate<cr>

" Ack
noremap <Leader>kc :Ack <cword><cr>
vnoremap <Leader>kv y:Ack <C-r>=fnameescape(@")<CR><CR>

" Load todo/GTD
nnoremap <silent> <leader>gs :e $HOME/Dropbox/Documents/GTD/Scratch.md<CR>

nnoremap <leader>sp :set spell!<CR>
nnoremap <leader>sf 1z=
map <Leader>se :setlocal spell spelllang=es_es<CR>
map <Leader>ss :setlocal spell spelllang=en_us<CR>

nnoremap <leader>w :w<CR>

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" bash like key for the command line
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>

inoremap  <Esc>    <NOP>
nnoremap j gj
nnoremap k gk

" Keep the cursor at the center of the screen when scrolling
nnoremap J jzz
nnoremap K kzz

" Copy current line and location
" nnoremap <leader>Y :let @a=expand("%t") . ':' . line(".")<CR>
nnoremap <leader>Y :let @a='- [[' . expand("%:t") . ']]' <CR>
nnoremap <leader>P <C-c>"ap

" Copy to the clipboard (mac)
vnoremap <leader>y :w !pbcopy<cr><cr>
nnoremap <leader><leader>p :w !pbcopy<cr><cr>

map <leader>R 1z=

map <leader>x :execute getline(".")<CR>

" Resize even
map <leader>E <C-w>=

nnoremap <silent> <leader>z :ZoomWin<CR>

nnoremap <leader><leader>c :call DRD_toggleCol()<CR>

" vim wiki
let g:vimwiki_map_prefix = '<leader>W'
let g:vimwiki_list = [
  \ { 
     \ 'path':'~/Dropbox/vimwiki/markdown/',
     \ 'ext':'.md','syntax':'markdown',
     \ 'path_html': '~/Dropbox/vimwiki/html/',
  \ },
  \ {"path":"~/Dropbox/vimwiki/wiki/"}
\ ]
map <leader>Ww :e ~/Dropbox/vimwiki/markdown/index.md<CR><CR>
map <leader>Wb :VimwikiAll2HTML<CR><CR>
  \:Vimwiki2HTMLBrowse<CR>
map <leader>Wy :VimwikiIndex<CR>:VimwikiMakeDiaryNote<CR>
map <leader>Wg <Esc>:VimwikiDiaryGenerateLinks<CR>

" Go to tab by number
noremap <leader>t gt
noremap <leader>T gT
"noremap <leader>1 1gt
"noremap <leader>2 2gt
"noremap <leader>3 3gt
"noremap <leader>4 4gt
"noremap <leader>5 4gt
"nnoremap <leader>1 :CtrlPMRU<CR>
"nnoremap <leader>2 :!open %<CR>

" solarized
"let g:solarized_diffmode="high" "default value is normal
"let g:solarized_visibility="high" " For :set list
"let g:solarized_contrast = "high"
syntax enable
let g:solarized_termcolors=256
if !has('gui_running')
  let g:solarized_termcolors=&t_Co
  let g:solarized_termtrans=1
endif

let g:gruvbox_contrast_dark = "low"
set background=dark
colorscheme gruvbox

map <leader>Bd :set background=dark<CR>
map <leader>Bl :set background=light<CR>

" --- COC
" Some servers have issues with backup files, see #649
"set nobackup
"set nowritebackup

" Better display for messages
""set cmdheight=2 

" You will have bad experience for diagnostic messages when it's default 4000.
"set updatetime=300

" don't give |ins-completion-menu| messages.
" set shortmess+=c

" always show signcolumns
"set signcolumn=yes

" CoC extensions
"let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-eslint', 'coc-prettier', 'coc-html']

" Add CoC ESLint if ESLint is installed
" if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
"  let g:coc_global_extensions += ['coc-eslint']
"endif
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)

"nnoremap <silent>K :call CocAction('doHover')<CR>

" Remap keys for applying codeAction to the current line.
"nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
"nmap <leader>qf  <Plug>(coc-fix-current)

" Show autocomplete when Tab is pressed
" inoremap <silent><expr> <Tab> coc#refresh()
" --- END COC

" --- vim-go
" Enable autocomplete
" setlocal omnifunc=go#complete#Complete

"let g:go_metalinter_autosave = 1

" Auto formatting and importing
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

" Status line types/signatures
let g:go_auto_type_info = 1
" ---  END vim-go

"autocmd BufRead,BufNewFile,BufWrite {*node_modules*} let g:ale_fix_on_save = 0

" --- Arduino 
au BufRead,BufNewFile *.ino,*.pde set filetype=c++

au BufRead,BufNewFile *.viki set ft=viki
let vikiNameSuffix=".viki"
let g:vikiOpenUrlWith_http = "silent !firefox %{FILE}"

let g:NERDTreeWinSize = 30
" let g:netrw_preview = 1
" let g:netrw_liststyle = 3
let g:NERDTreeDirArrows=1
let g:NERDTreeChDirMode=2
let NERDTreeIgnore=['\.o$', '\~$', '\.pyc$', 'node_modules']
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeHighlightCursorline = 0

let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = '\v\~$|node_modules|.next|.vercel|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
" 'r' - the nearest ancestor that contains one of these directories or
"       files: .git .hg .svn .bzr
" 'a' - like c, but only if the current working directory outside of CtrlP is
" not a direct ancestor of the directory of the current file.
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

let g:ctrlp_max_height = 10 " set the maximum height of the match window
let g:ctrlp_show_hidden = 1 " set this to 1 if you want CtrlP to scan for dotfiles and dotdirs
let g:ctrlp_extensions = ['quickfix']

let MRU_Use_Current_Window = 1

" Ack
let g:ack_use_dispatch = 1

" Invisible colors
" hi NonText    ctermfg=240 ctermbg=NONE  gui=NONE cterm=NONE guibg=NONE guifg=NONE
" hi SpecialKey ctermfg=240 ctermbg=NONE  gui=NONE cterm=NONE guibg=NONE guifg=NONE

let g:airline_powerline_fonts = 1

" Presentation mode
nmap <leader><leader>1 :set relativenumber! number! showmode! showcmd! hidden! ruler!<CR>

