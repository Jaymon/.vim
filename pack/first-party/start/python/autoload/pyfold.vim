
" NOTE -- echom doesn't work when this function is called when folding, you can
" only get it to print when calling this method manually `:call or setting
" debug for the messages pyfold#fold(v:lnum), to see what the function is
" doing, uncomment `g:fold_debug` and the `call add(g:fold_debug, ...)` line
" and then when you open a file just echo it `echo g:fold_debug`
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


" Return 1 if this line is a decorator line (start of new fold)
function! pyfold#isDecorator(line)
    return a:line =~ '^\s*@\S'

endfunction


" Return 1 if this line is a definition line (start of new fold)
function pyfold#isDefinition(line)
    return a:line =~ '^\s*\(class\|def\|async def\)\s'

endfunction


" Return 1 if this line is a blank line (only whitespace)
function pyfold#isBlank(line)
    return a:line =~ '^\s*$'

endfunction


" Return 1 if this line is only a comment
function pyfold#isComment(line)
    return a:line =~ '^\s*#'

endfunction


"function pyfold#getPrevDepth(depth)
"	let prev_depth = a:depth - 1
"	if prev_depth < 0
"		let prev_depth = 0
"
"	endif
"
"	return prev_depth
"
"endfunction


" Get the depth of the line number, this is the fold level
function pyfold#getDepth(lnum)
	let ind = indent(a:lnum)
	return (ind / &shiftwidth) + 1

endfunction


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

	if pyfold#isDecorator(cline)
        if g:fold_decorated == 0
			let g:fold_depth = pyfold#getDepth(v:lnum)
            let ret = ">" . g:fold_depth
            let g:fold_decorated = 1

        endif

	elseif pyfold#isDefinition(cline)
        if g:fold_decorated == 0
			let g:fold_depth = pyfold#getDepth(v:lnum)
            let ret = ">" . g:fold_depth

        endif

        let g:fold_decorated = 0

	elseif pyfold#isBlank(cline)
		if g:fold_depth > 0
			let nnum = nextnonblank(v:lnum + 1)
			let nline = getline(nnum)
			if pyfold#isDefinition(nline) || pyfold#isDecorator(nline)
				let depth = pyfold#getDepth(nnum)
				if depth <= g:fold_depth
					let g:fold_depth = max([0, depth - 1])
					"let g:fold_depth = pyfold#getPrevDepth(depth)

				endif
			endif
		endif

		let ret = g:fold_depth

	elseif pyfold#isComment(cline)
        let ret = g:fold_depth

	else " normal line
		let depth = pyfold#getDepth(v:lnum)
        if depth < g:fold_depth
			"let g:fold_depth = pyfold#getPrevDepth(depth)
			let g:fold_depth = max([0, depth - 1])

        endif

		let ret = g:fold_depth

    endif

    "call add(g:fold_debug, v:lnum.". ".ret." line: ".cline."\n")
    return ret

endfunction

