"##############################################################################
" configure Tagbar
" http://majutsushi.github.com/tagbar/
"
" This should load before pack/third-party/start/tagbar, you can verify this
" by running `:scriptnames` and verifying this loaded before any other
" tagbar things
"##############################################################################

nnoremap RR :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_sort = 1
let g:tagbar_expand = 0
let g:tagbar_foldlevel = 0
let g:tagbar_autoshowtag = 1

