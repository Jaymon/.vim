" http://wiki.python.org/moin/Vim
"au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4
" TODO -- I think this is all set in the pymode indentation, so I can get rid
" of this if I keep pymode indentation
setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4

" python comments should auto-wrap and if you hit enter it should add a new
" comment. I got this from ftplugin/vim.vim in vim proper
setlocal fo-=t fo+=crl
if &tw == 0
  setlocal tw=80
endif

" config for python syntax highlighting plugin
let python_highlight_all = 1
let python_highlight_space_errors = 0
let python_slow_sync = 1
let python_version_2 = 1

" From pymode https://github.com/klen/python-mode/blob/develop/after/ftplugin/python.vim
let g:pymode = 1
let g:pymode_motion = 1
let g:pymode_indent = 1

" we don't support these, but we need to turn them off to avoid errors
let g:pymode_rope = 0
let g:pymode_rope_completion = 0

