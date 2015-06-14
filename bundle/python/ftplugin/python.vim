" http://wiki.python.org/moin/Vim
"au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4
setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4

" config for python highlighting plugin
let python_highlight_all = 1
let python_highlight_space_errors = 0
let python_slow_sync = 1

" From pymode https://github.com/klen/python-mode/blob/develop/after/ftplugin/python.vim
let g:pymode = 1
let g:pymode_motion = 1
let g:pymode_indent = 1

" we don't support these, but we need to turn them off to avoid errors
let g:pymode_rope = 0
let g:pymode_rope_completion = 0

