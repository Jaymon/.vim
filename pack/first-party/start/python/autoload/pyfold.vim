
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

" Keeps track of current fold level so the function can easily backtrack
" levels when it finds a line with a lower indent than the current fold
" indent
let g:fold_depth = 0

" Fold python on class and function/method breaks
"
" The algo is pretty simple since this is called for each line in the buffer
" when a new buffer is loaded/changed, basically, it just marks a new buffer as
" starting when it finds a class or def block and inherits when it isn't one
" of those blocks
function! pyfold#fold()
    let cline = getline(v:lnum)

    " we reset our global variables if we are back at the top of the file
    if v:lnum == 1
        let g:fold_depth = 0
        let g:fold_decorated = 0

    endif

    if cline =~ '^\s*@\S' " decorator fold line
        if g:fold_decorated == 0
            let cind=indent(v:lnum)
            let ret = ">" . (cind / &shiftwidth + 1)
            let g:fold_decorated = 1

        endif

    elseif cline =~ '^\s*\(class\|def\|async def\)\s' " fold line
        if g:fold_decorated == 0
            let cind=indent(v:lnum)
            let g:fold_depth = (cind / &shiftwidth + 1)
            let ret = ">" . g:fold_depth

        endif

        let g:fold_decorated = 0

    elseif cline =~ '^\s*$' " blank line
        let ret = g:fold_depth

    elseif cline =~ '^\s*#' " comment line
        let ret = g:fold_depth

	else " normal line
        let cind=indent(v:lnum)
        let depth = (cind / &shiftwidth + 1)
        if depth < g:fold_depth
            let g:fold_depth = (depth - 1)
            if g:fold_depth < 0
                let g:fold_depth = 0

            endif

            let ret = g:fold_depth

        else
            let ret = g:fold_depth

        endif

    endif

    "call add(g:fold_debug, v:lnum.". ".ret." line: ".cline."\n")
    return ret

endfunction

