
" python comments should auto-wrap and if you hit enter it should add a new
" comment. I got this from ftplugin/vim.vim in vim proper
setlocal fo-=t fo+=crl
if &tw == 0
  setlocal tw=83
endif

" config for python syntax highlighting plugin
let python_highlight_all = 1
let python_space_error_highlight = 0

" From pymode https://github.com/klen/python-mode/blob/develop/after/ftplugin/python.vim
let g:pymode = 1
let g:pymode_motion = 1
let g:pymode_indent = 1
" indenting in parens/brackets didn't work until I set this to 0, no idea why
let g:pymode_indent_hanging_width = 0

" we don't support these, but we need to turn them off to avoid errors
let g:pymode_rope = 0
let g:pymode_rope_completion = 0

" this is the correct command but it doesn't work in vim8 :( maybe someday
" :help format-comments
" https://github.com/vim/vim/issues/1696
" setlocal comments=s:\"\"\",m3:\ ,eb:\"\"\",b:#,fb:-

" Ignore files matching these patterns when opening files based on a glob pattern.
set wildignore+=.pyc

" other values like this are mapped in after/ftplugin/python.vim but I don't
" want to modify that file because it can be replaced, so I put them here
if g:pymode_motion
    " added by Jay on 12-13-2016 because I can never remember [M etc. This is
    " a copy/paste from after/ftplugin/python.vim's [M and ]M blocks with
    " just the ]M changed to ]} and the [M changed to [{

    nnoremap <buffer> ]}  :<C-U>call pymode#motion#move('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', '')<CR>
    nnoremap <buffer> [{  :<C-U>call pymode#motion#move('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', 'b')<CR>
    onoremap <buffer> ]}  :<C-U>call pymode#motion#move('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', '')<CR>
    onoremap <buffer> [{  :<C-U>call pymode#motion#move('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', 'b')<CR>
    vnoremap <buffer> ]}  :call pymode#motion#vmove('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', '')<CR>
    vnoremap <buffer> [{  :call pymode#motion#vmove('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', 'b')<CR>

end
