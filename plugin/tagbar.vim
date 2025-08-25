"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" configure Tagbar
" https://github.com/preservim/tagbar
"
" Tagbar makes it easy to see things like classes and methods in the current
" buffer
"
" Docs are here (or in vim help):
"	https://github.com/preservim/tagbar/blob/master/doc/tagbar.txt
"
" This should load before pack/third-party/start/tagbar, you can verify this
" by running `:scriptnames` and verifying this loaded before any other
" tagbar things
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap RR :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

" This sorts the tagbar list into alphabetical order, but is that really what
" I want? Many times I have an internal idea of the file structure and where
" classes and stuff are located and this breaks that
"let g:tagbar_sort = 1
"let g:tagbar_case_insensitive = 1

let g:tagbar_expand = 0
let g:tagbar_foldlevel = 0
let g:tagbar_autoshowtag = 1

" only speeds up slow file systems because it is the cache of the file not the
" ctags output
let g:tagbar_use_cache = 0

