
if &tw == 0
    setlocal tw=79
endif


" this is the correct command but it doesn't work in vim8 :( maybe someday
" :help format-comments
" https://github.com/vim/vim/issues/1696
" setlocal comments=s:\"\"\",m3:\ ,eb:\"\"\",b:#,fb:-

" This is so close to working in vim9, the first line wraps just fine but then
" it doesn't wrap correctly after that, I've already spent too much time trying 
" to get it to work so I'm commenting it out again for another N years :(
" https://www.reddit.com/r/vim/comments/9kz5rk/
" set comments+=sf:\"\"\",eb:\"\"\"


" config for python syntax highlighting plugin
let python_highlight_all = 1
let python_space_error_highlight = 0


" Ignore files matching these patterns when opening files based on a
" glob pattern.
set wildignore+=.pyc


" python folding
" https://stackoverflow.com/a/360634
"set foldmethod=indent
"set foldnestmax=2
set foldmethod=expr
" corresponds to autoload/pyfold.vim:fold, this is evaluated for each line in
" the buffer
set foldexpr=pyfold#fold()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pymode Pymotion
"
" These are the shortcuts that activate `autoload/pymode/motion.vim`
"
" If I was using the pymode plugin these would be located at:
"   https://github.com/python-mode/python-mode/blob/develop/after/ftplugin/python.vim
"
" This helpfile might be helpful:
"   https://github.com/python-mode/python-mode/blob/develop/doc/pymode.txt
"
" I should check `&magic` but this setting is almost never switched off, and
" `:help magic` recommends never switching it off:
"   The 'magic' option should always be set, but it can be switched off for
"   Vi compatibility

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move to the next class
nnoremap <buffer> ]]  :<C-U>call pymode#motion#move('^<Bslash>(class<Bslash><bar><Bslash>%(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>)<Bslash>s', '')<CR>
vnoremap <buffer> ]]  :call pymode#motion#vmove('^<Bslash>(class<Bslash><bar><Bslash>%(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>)<Bslash>s', '')<CR>
onoremap <buffer> ]]  :<C-U>call pymode#motion#move('^<Bslash>(class<Bslash><bar><Bslash>%(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>)<Bslash>s', '')<CR>
" Original pymode shortcuts
" Both C and c work, I'm not sure why this omits the vnoremap but the fact that
" both next and prev omit it in the original file makes me think it's
" intentional
nnoremap <buffer> ]C  :<C-U>call pymode#motion#move('^<Bslash>(class<Bslash><bar><Bslash>%(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>)<Bslash>s', '')<CR>
onoremap <buffer> ]C  :<C-U>call pymode#motion#move('^<Bslash>(class<Bslash><bar><Bslash>%(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>)<Bslash>s', '')<CR>


" Move to the previous class
nnoremap <buffer> [[  :<C-U>call pymode#motion#move('^<Bslash>(class<Bslash><bar><Bslash>%(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>)<Bslash>s', 'b')<CR>
vnoremap <buffer> [[  :call pymode#motion#vmove('^<Bslash>(class<Bslash><bar><Bslash>%(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>)<Bslash>s', 'b')<CR>
onoremap <buffer> [[  :<C-U>call pymode#motion#move('^<Bslash>(class<Bslash><bar><Bslash>%(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>)<Bslash>s', 'b')<CR>
" Original pymode shortcuts
nnoremap <buffer> [C  :<C-U>call pymode#motion#move('^<Bslash>(class<Bslash><bar><Bslash>%(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>)<Bslash>s', 'b')<CR>
onoremap <buffer> [C  :<C-U>call pymode#motion#move('^<Bslash>(class<Bslash><bar><Bslash>%(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>)<Bslash>s', 'b')<CR>


" Move to the next method/function
nnoremap <buffer> ]}  :<C-U>call pymode#motion#move('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', '')<CR>
vnoremap <buffer> ]}  :call pymode#motion#vmove('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', '')<CR>
onoremap <buffer> ]}  :<C-U>call pymode#motion#move('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', '')<CR>
" original pymode motion shortcuts, both M and m work
nnoremap <buffer> ]M  :<C-U>call pymode#motion#move('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', '')<CR>
vnoremap <buffer> ]M  :call pymode#motion#vmove('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', '')<CR>
onoremap <buffer> ]M  :<C-U>call pymode#motion#move('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', '')<CR>

" Move to the previous method/function
nnoremap <buffer> [{  :<C-U>call pymode#motion#move('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', 'b')<CR>
onoremap <buffer> [{  :<C-U>call pymode#motion#move('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', 'b')<CR>
vnoremap <buffer> [{  :call pymode#motion#vmove('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', 'b')<CR>
" original pymode motion shortcuts, both M and m work
nnoremap <buffer> [M  :<C-U>call pymode#motion#move('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', 'b')<CR>
onoremap <buffer> [M  :<C-U>call pymode#motion#move('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', 'b')<CR>
vnoremap <buffer> [M  :call pymode#motion#vmove('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', 'b')<CR>


" operator pending mode for classes (eg, `dC` will delete the entire class)
onoremap <buffer> C  :<C-U>call pymode#motion#select_c('^<Bslash>s*class<Bslash>s', 0)<CR>

" Select a class inclusive. Ex: vaC, daC, yaC, caC (operator modes)
onoremap <buffer> aC :<C-U>call pymode#motion#select_c('^<Bslash>s*class<Bslash>s', 0)<CR>
vnoremap <buffer> aC :<C-U>call pymode#motion#select_c('^<Bslash>s*class<Bslash>s', 0)<CR>

"Select inner class. Ex: viC, diC, yiC, ciC (operator modes)
onoremap <buffer> iC :<C-U>call pymode#motion#select_c('^<Bslash>s*class<Bslash>s', 1)<CR>
vnoremap <buffer> iC :<C-U>call pymode#motion#select_c('^<Bslash>s*class<Bslash>s', 1)<CR>


" operator pending mode for methods/functions (eg, `dM` will delete the entire 
" method)
onoremap <buffer> M   :<C-U>call pymode#motion#select('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=@', '^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', 0)<CR>

" Select a function or method inclusive. Ex: vaM, daM, yaM, caM (operator modes)
onoremap <buffer> aM  :<C-U>call pymode#motion#select('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=@', '^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', 0)<CR>
vnoremap <buffer> aM  :<C-U>call pymode#motion#select('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=@', '^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', 0)<CR>

" Select inner function or method. Ex: viM, diM, yiM, ciM (operator modes)
onoremap <buffer> iM  :<C-U>call pymode#motion#select('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=@', '^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', 1)<CR>
vnoremap <buffer> iM  :<C-U>call pymode#motion#select('^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=@', '^<Bslash>s*<Bslash>(async<Bslash>s<Bslash>+<Bslash>)<Bslash>=def<Bslash>s', 1)<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

