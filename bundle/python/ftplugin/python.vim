" http://wiki.python.org/moin/Vim
"au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4
setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4

" config for python highlighting plugin
let python_highlight_all = 1
let python_highlight_space_errors = 0
let python_slow_sync = 1

" From pymode https://github.com/klen/python-mode/blob/develop/after/ftplugin/python.vim
let g:pymode_motion = 1
if g:pymode_motion
  nnoremap <buffer> ]]  :<C-U>call pymode#motion#move('<Bslash>v^(class<bar>def)<Bslash>s', '')<CR>
  nnoremap <buffer> [[  :<C-U>call pymode#motion#move('<Bslash>v^(class<bar>def)<Bslash>s', 'b')<CR>
  nnoremap <buffer> ]C  :<C-U>call pymode#motion#move('<Bslash>v^(class<bar>def)<Bslash>s', '')<CR>
  nnoremap <buffer> [C  :<C-U>call pymode#motion#move('<Bslash>v^(class<bar>def)<Bslash>s', 'b')<CR>
  nnoremap <buffer> ]M  :<C-U>call pymode#motion#move('^<Bslash>s*def<Bslash>s', '')<CR>
  nnoremap <buffer> [M  :<C-U>call pymode#motion#move('^<Bslash>s*def<Bslash>s', 'b')<CR>

  onoremap <buffer> ]]  :<C-U>call pymode#motion#move('<Bslash>v^(class<bar>def)<Bslash>s', '')<CR>
  onoremap <buffer> [[  :<C-U>call pymode#motion#move('<Bslash>v^(class<bar>def)<Bslash>s', 'b')<CR>
  onoremap <buffer> ]C  :<C-U>call pymode#motion#move('<Bslash>v^(class<bar>def)<Bslash>s', '')<CR>
  onoremap <buffer> [C  :<C-U>call pymode#motion#move('<Bslash>v^(class<bar>def)<Bslash>s', 'b')<CR>
  onoremap <buffer> ]M  :<C-U>call pymode#motion#move('^<Bslash>s*def<Bslash>s', '')<CR>
  onoremap <buffer> [M  :<C-U>call pymode#motion#move('^<Bslash>s*def<Bslash>s', 'b')<CR>

  vnoremap <buffer> ]]  :call pymode#motion#vmove('<Bslash>v^(class<bar>def)<Bslash>s', '')<CR>
  vnoremap <buffer> [[  :call pymode#motion#vmove('<Bslash>v^(class<bar>def)<Bslash>s', 'b')<CR>
  vnoremap <buffer> ]M  :call pymode#motion#vmove('^<Bslash>s*def<Bslash>s', '')<CR>
  vnoremap <buffer> [M  :call pymode#motion#vmove('^<Bslash>s*def<Bslash>s', 'b')<CR>

  onoremap <buffer> C  :<C-U>call pymode#motion#select('^<Bslash>s*class<Bslash>s', 0)<CR>
  onoremap <buffer> aC :<C-U>call pymode#motion#select('^<Bslash>s*class<Bslash>s', 0)<CR>
  onoremap <buffer> iC :<C-U>call pymode#motion#select('^<Bslash>s*class<Bslash>s', 1)<CR>
  vnoremap <buffer> aC :<C-U>call pymode#motion#select('^<Bslash>s*class<Bslash>s', 0)<CR>
  vnoremap <buffer> iC :<C-U>call pymode#motion#select('^<Bslash>s*class<Bslash>s', 1)<CR>

  onoremap <buffer> M  :<C-U>call pymode#motion#select('^<Bslash>s*def<Bslash>s', 0)<CR>
  onoremap <buffer> aM :<C-U>call pymode#motion#select('^<Bslash>s*def<Bslash>s', 0)<CR>
  onoremap <buffer> iM :<C-U>call pymode#motion#select('^<Bslash>s*def<Bslash>s', 1)<CR>
  vnoremap <buffer> aM :<C-U>call pymode#motion#select('^<Bslash>s*def<Bslash>s', 0)<CR>
  vnoremap <buffer> iM :<C-U>call pymode#motion#select('^<Bslash>s*def<Bslash>s', 1)<CR>

end
