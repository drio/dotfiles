let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
let NERDTreeMapPreviewSplit = "gi"
let NERDTreeMapCloseChildren = "X"
let Db_ui_buffer_name_generator =  0 
let NERDTreeShowHidden =  0 
let NERDTreeMapCloseDir = "x"
let NERDTreeSortHiddenFirst =  1 
let NERDTreeMinimalUI =  0 
let NERDTreeShowLineNumbers =  0 
let NERDTreeRespectWildIgnore =  0 
let NERDTreeAutoDeleteBuffer =  0 
let NERDTreeBookmarksFile = "/Users/drio/.NERDTreeBookmarks"
let NERDTreeMapToggleHidden = "I"
let NERDTreeWinSize =  31 
let NERDTreeMenuUp = "k"
let DevIconsEnableFoldersOpenClose =  0 
let NERDTreeUseTCD =  0 
let WebDevIconsNerdTreeAfterGlyphPadding = " "
let DevIconsEnableDistro =  1 
let WebDevIconsUnicodeDecorateFolderNodesDefaultSymbol = ""
let NERDTreeMapPreview = "go"
let Taboo_tabs = "1	Kafka\n2	nginx\n"
let NERDTreeNotificationThreshold =  100 
let NERDTreeMapActivateNode = "o"
let NERDTreeMapCustomOpen = "<CR>"
let NERDTreeWinPos = "left"
let NERDTreeDirArrowExpandable = "▸"
let WebDevIconsUnicodeDecorateFileNodes =  1 
let NERDTreeMapMenu = "m"
let DevIconsEnableFolderPatternMatching =  1 
let NERDTreeStatusline = "%{exists('b:NERDTree')?b:NERDTree.root.path.str():''}"
let NERDTreeMapOpenInTabSilent = "T"
let NERDTreeMapHelp = "?"
let NERDTreeMapJumpParent = "p"
let NERDTreeMapToggleFilters = "f"
let NERDTreeCascadeOpenSingleChildDir =  1 
let NERDTreeMapJumpPrevSibling = "<C-k>"
let WebDevIconsTabAirLineAfterGlyphPadding = ""
let NERDTreeNodeDelimiter = ""
let NERDTreeShowBookmarks =  0 
let NERDTreeRemoveDirCmd = "rm -rf "
let DevIconsArtifactFixChar = " "
let NERDTreeMapOpenInTab = "t"
let NERDTreeChDirMode =  0 
let NERDTreeCreatePrefix = "silent"
let WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = ""
let NERDTreeAutoCenterThreshold =  3 
let NERDTreeShowFiles =  1 
let NERDTreeMapOpenSplit = "i"
let NERDTreeGitStatusUpdateOnCursorHold =  1 
let NERDTreeCaseSensitiveSort =  0 
let NERDTreeHijackNetrw =  1 
let DevIconsEnableNERDTreeRedraw =  0 
let NERDTreeCascadeSingleChildDir =  1 
let NERDTreeMapRefresh = "r"
let NERDTreeBookmarksSort =  1 
let NERDTreeHighlightCursorline =  1 
let WebDevIconsUnicodeByteOrderMarkerDefaultSymbol = ""
let WebDevIconsNerdTreeGitPluginForceVAlign =  1 
let DevIconsAppendArtifactFix =  0 
let NERDTreeMouseMode =  1 
let WebDevIconsUnicodeDecorateFolderNodes =  1 
let NERDTreeMapCWD = "CD"
let NERDTreeNaturalSort =  0 
let WebDevIconsNerdTreeBeforeGlyphPadding = " "
let NERDTreeMapPreviewVSplit = "gs"
let WebDevIconsUnicodeDecorateFolderNodesExactMatches =  1 
let NERDTreeMapUpdir = "u"
let WebDevIconsUnicodeDecorateFolderNodesSymlinkSymbol = ""
let NERDTreeMapJumpRoot = "P"
let NERDTreeGlyphReadOnly = "RO"
let NERDTreeMapChdir = "cd"
let NERDTreeMenuDown = "j"
let NERDTreeMapToggleZoom = "A"
let NERDTreeMarkBookmarks =  1 
let NERDTreeMinimalMenu =  0 
let NERDTreeMapRefreshRoot = "R"
let NERDTreeAutoCenter =  1 
let NERDTreeMapOpenVSplit = "s"
let NERDTreeMapJumpLastChild = "J"
let NERDTreeMapDeleteBookmark = "D"
let NERDTreeMapJumpNextSibling = "<C-j>"
let NERDTreeUpdateOnCursorHold =  1 
let NERDTreeCopyCmd = "cp -r "
let NERDTreeMapQuit = "q"
let NERDTreeMapChangeRoot = "C"
let NERDTreeSortDirs =  1 
let NERDTreeMapToggleFiles = "F"
let DevIconsEnableFolderExtensionPatternMatching =  0 
let NERDTreeMapOpenExpl = "e"
let NERDTreeMapJumpFirstChild = "K"
let NERDTreeDirArrowCollapsible = "▾"
let NERDTreeMapOpenRecursively = "O"
let NERDTreeMapToggleBookmarks = "B"
let DevIconsDefaultFolderOpenSymbol = ""
let WebDevIconsTabAirLineBeforeGlyphPadding = " "
let WebDevIconsUnicodeGlyphDoubleWidth =  1 
let NERDTreeMapUpdirKeepOpen = "U"
let NERDTreeQuitOnOpen =  0 
silent only
silent tabonly
cd ~/dev/github.com/drio/aws-kafka
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
set shortmess=aoO
badd +1 Makefile
badd +0 ~/dev/github.com/drio/nginx-local-dev-proxy/nginx.conf
argglobal
%argdel
$argadd Makefile
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit Makefile
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=1
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 4 - ((3 * winheight(0) + 29) / 59)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 4
normal! 0
tabnext
edit ~/dev/github.com/drio/nginx-local-dev-proxy/nginx.conf
argglobal
balt ~/dev/github.com/drio/nginx-local-dev-proxy/nginx.conf
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=1
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 29) / 59)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
lcd ~/dev/github.com/drio/nginx-local-dev-proxy
tabnext 1
set stal=1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
