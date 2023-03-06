"##############################################################################
" configure NERDTree
" https://github.com/scrooloose/nerdtree
"
" This should load before pack/third-party/start/NERDTree, you can verify this
" by running `:scriptnames` and verifying this loaded before any other
" Nerdtree things
"##############################################################################

"autocmd bufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"nnoremap RN :NERDTreeTabsToggle<CR>
nnoremap RN :NERDTreeMirrorToggle<CR>
let NERDTreeIgnore = ['\.pyc$[[file]]', '__pycache__$[[dir]]']
let NERDTreeQuitOnOpen = 1
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_open_on_new_tab = 0
"#let g:nerdtree_tabs_autoclose = 1
" default is 31...
let NERDTreeWinSize = 40

" https://stackoverflow.com/a/5057406/5006
" you can toggle this behavior with shift+i
let NERDTreeShowHidden=1

