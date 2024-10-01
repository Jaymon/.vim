
" NOTE -- echom doesn't work when this function is called when folding, you can
" only get it to print when calling this method manually `:call
" pyfold#fold(v:lnum), to see what the function is doing, uncomment
" `g:fold_debug` and the `call add(g:fold_debug, ...)` line and then when you
" open a file just echo it `echo g:fold_debug`
"
"let g:fold_debug = []

" set to 1 if a decorator is encountered, it's flipped back to zero when the
" class/function signature is found. The other way this could be done is to
" check the previous line for an @ in the class/def if block, that would get
" rid of this global variable
let g:fold_decorated = 0

" Fold python on class and function/method breaks
"
" The algo is pretty simple since this is called for each line in the buffer
" when a new buffer is loaded/changed, basically, it just marks a new buffer as
" starting when it finds a class or def block and inherits when it isn't one
" of those blocks
function! pyfold#fold(lnum)
    let cline = getline(a:lnum)
    let cind=indent(a:lnum)

    let ret = '='
    if cline =~ '^\s*@\S'
        if g:fold_decorated == 0
            let ret = ">" . (cind / &shiftwidth + 1)
            let g:fold_decorated = 1

        endif

    elseif cline =~ '^\s*\(class\|def\|async def\)\s'
        if g:fold_decorated == 0
            let ret = ">" . (cind / &shiftwidth + 1)

        endif

        let g:fold_decorated = 0

    elseif cline =~ '^\s*$'
        let ret = "="

    endif
    "call add(g:fold_debug, a:lnum.". ".ret." line: ".cline."\n")
    return ret

endfunction

