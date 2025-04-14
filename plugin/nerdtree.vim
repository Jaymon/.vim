"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" configure NERDTree
" https://github.com/scrooloose/nerdtree
"
" NERDTree is a file browser
"
" This should load before pack/third-party/start/NERDTree, you can verify this
" by running `:scriptnames` and verifying this loaded before any other
" Nerdtree things
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""
" vim nerdtree open and expand to current file
"
" Toggle NERDTree's tab and open to the opened file in relation to the current
" working directory
"
" https://github.com/preservim/nerdtree/issues/480
" https://vi.stackexchange.com/a/5340
"
" I was hopeful this answer would work, but it didn't:
"   https://superuser.com/a/567013
""
function! NERDTreeFindToggle()
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    NERDTreeClose

  else
    if (expand("%:t") != '')
      NERDTreeFind

    else
      NERDTreeToggle

    endif

  endif

endfunction


nnoremap RN :call NERDTreeFindToggle()<CR>
"nnoremap RN :NERDTreeMirrorToggle<CR>

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

