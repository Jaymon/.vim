" This runs after $VIMRUNTIME/ftplugin/python.vim

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


" python folding
" https://stackoverflow.com/a/360634
"set foldmethod=indent
"set foldnestmax=2
set foldmethod=expr
" corresponds to autoload/pyfold.vim:fold, this is evaluated for each line in
" the buffer
set foldexpr=pyfold#fold()

