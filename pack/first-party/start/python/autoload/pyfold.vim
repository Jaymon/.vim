
"let g:fold_debug = []
" NOTE -- echom doesn't work when this function is called when folding, you can
" only get it to print when calling this method manually `:call
" pyfold#fold(v:lnum), to see what the function is doing, uncomment
" `g:fold_debug` and the `call add(g:fold_debug, ...)` line and then when you
" open a file just echo it `echo g:fold_debug`
function! pyfold#fold(lnum)
    let cline = getline(a:lnum)
    let cind=indent(a:lnum)

    let ret = '='
    if cline =~ '^\s*\(class\|def\|async def\)\s'
        let ret = ">" . (cind / &shiftwidth + 1)

    elseif cline =~ '^\s*$'
        let ret = "="

    endif
    "call add(g:fold_debug, a:lnum.". ".ret." line: ".cline."\n")
    return ret

"    let ret = 0
"    let cline = getline(a:lnum)
"    if cline =~ '^\s*\(class\|def\|async def\)\s'
"        let ret = ">" . (cind / &shiftwidth + 1)
"    endif
"
"    return ret

"    if a:lnum > 10
"        return 1
"    else
"        return 0
    "echom a:lnum
    "echom "here ".a:lnum
    " Determine the current folding level
"    let cline = getline(a:lnum)
"
"    if cline =~ '^\s*$'
"        " Blank lines always get the same fold level as the previous line
"        let ret =  "="
"
"    else
"        let cind=indent(a:lnum)
"
"        " Get the next non-blank line
"        let nnum = nextnonblank(a:lnum + 1)
"        let nind = indent(nnum)
"        let nline = getline(nnum)
"
"        " Get the previous non-blank line
"        let pnum = prevnonblank(a:lnum - 1)
"
"        " Get the previous line indent level
"    "    let plvlnum = a:lnum - 1
"    "    let lvl = foldlevel(plvlnum)
"
"        " If the previous non-blank line is the start of the file,
"        " we are not in a fold
"        if pnum == 0
"            let ret =  0
"
"        elseif nnum == 0
"            " If there are no more non-blank lines, the fold should end
"            let ret =  0
"
"        else
"            if cline =~ '^\s*\(class\|def\|async def\)\s'
"                let ret = ">" . (cind / &shiftwidth + 1)
"            endif
"
"        endif
"    endif
"
"    "echom "ret: ".ret.", line: ".line."\n"
"    return ret
endfunction

