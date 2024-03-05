" Vim indent file
" Language:         Python
" Maintainer:	    Jay Marcyes <vim@marcyes.com>
" Last Change:      2024 Mar 5
" Credits:          David Bustos <bustos@caltech.edu>
"                   Eric Mc Sween <em@tomcom.de>
"                   Bram Moolenaar <Bram@vim.org>
"
" Jay started modifying this file on 2021-01-04, it is now pretty different
" than the original file
"
" helpful links:
"   https://github.com/vim/vim/blob/master/runtime/doc/usr_41.txt
"   https://psy.swansea.ac.uk/staff/carter/vim/vim_indent.htm
"   https://github.com/vim/vim/tree/master/runtime/indent
"   https://github.com/vim/vim/blob/master/runtime/doc/indent.txt
"   https://learnvimscriptthehardway.stevelosh.com/chapters/01.html
"
" I originally got this file years ago and used it without modification, then
" I started to modify it around 2021. Then towards the end of 2022 and early
" 2023 I disabled it in an attempt to use Vim's builtin python indent script.
" Turns out I didn't like it and so I'm back to using this old file but I'm
" marking myself as the maintainer because I don't know what I've changed and
" haven't touched anymore. I did move the parts that seemed useful from the
" builtin vim indent found at:
"
"   /Applications/MacVim.app/Contents/Resources/vim/runtime/autoload/python.vim
"
" I tried to name my indentexpr python#GetIndent but it didn't work (1-13-2023).
"
" You can see what function is being used to indent:
"
"   set indentexpr
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

setlocal expandtab
setlocal nolisp
setlocal autoindent
setlocal indentexpr=GetPythonIndent(v:lnum)
setlocal indentkeys+=<:>,=elif,=except

let b:undo_indent = "setl ai< inde< indk< lisp<"
let s:maxoff = 50


" Find backwards the closest open parenthesis/bracket/brace.
function! s:SearchParensPair()
    let line = line('.')
    let col = col('.')

    " Skip strings and comments and don't look too far
    let skip = "line('.') < " . (line - s:maxoff) . " ? dummy :" .
        \ 'synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name") =~? ' .
        \ '"string\\|comment"'

    " Search for parentheses
    call cursor(line, col)
    let parlnum = searchpair('(', '', ')', 'bW', skip)
    let parcol = col('.')

    " Search for brackets
    call cursor(line, col)
    let par2lnum = searchpair('\[', '', '\]', 'bW', skip)
    let par2col = col('.')

    " Search for braces
    call cursor(line, col)
    let par3lnum = searchpair('{', '', '}', 'bW', skip)
    let par3col = col('.')

    " Get the closest match
    if par2lnum > parlnum || (par2lnum == parlnum && par2col > parcol)
        let parlnum = par2lnum
        let parcol = par2col
    endif
    if par3lnum > parlnum || (par3lnum == parlnum && par3col > parcol)
        let parlnum = par3lnum
        let parcol = par3col
    endif 

    " Put the cursor on the match
    if parlnum > 0
        call cursor(parlnum, parcol)
    endif
    return parlnum
endfunction


" Find the start of a multi-line statement
function! s:StatementStart(lnum)
    let lnum = a:lnum
    while 1
        if getline(lnum - 1) =~ '\\$'
            let lnum = lnum - 1
        else
            call cursor(lnum, 1)
            let maybe_lnum = s:SearchParensPair()
            if maybe_lnum < 1
                return lnum
            else
                let lnum = maybe_lnum
            endif
        endif
    endwhile
endfunction


" Find the block starter that matches the current line
function! s:BlockStarter(lnum, block_start_re)
    let lnum = a:lnum
    let maxindent = 10000       " whatever
    while lnum > 1
        let lnum = prevnonblank(lnum - 1)
        if indent(lnum) < maxindent
            if getline(lnum) =~ a:block_start_re
                return lnum
            else 
                let maxindent = indent(lnum)
                " It's not worth going further if we reached the top level
                if maxindent == 0
                    return -1
                endif
            endif
        endif
    endwhile
    return -1
endfunction


" Find the block matching lnum's indent and see if it is a match, fallback to
" s:BlockStarter if needed
function! s:BlockMatcher(lnum, block_start_re)
    let lnum = a:lnum
    let lindent = indent(lnum)
    while lnum > 1
        echom "lnum: ".lnum
        let lnum = prevnonblank(lnum - 1)
        let pindent = indent(lnum)
        if pindent <= lindent
            if getline(lnum) =~ a:block_start_re
                return lnum

            else 
                if pindent == 0
                    return -1

                else
                    " we're done if we've gone passed the indent we're looking
                    " for
                    return s:BlockStarter(a:lnum, a:block_start_re)

                endif
            endif

        endif

    endwhile

    return -1

endfunction


function! GetPythonIndent(lnum)

    " First line has indent 0
    if a:lnum == 1
        return 0
    endif

    " If we can find an open parenthesis/bracket/brace, line up with it.
    call cursor(a:lnum, 1)
    let parlnum = s:SearchParensPair()
    if parlnum > 0
        let parcol = col('.')
        let closing_paren = match(getline(a:lnum), '^\s*[])}]') != -1

        " ADDED BY JAY ON 2021-01-04
        if closing_paren
            return indent(parlnum)
        else
            let l:indent_width = (g:pymode_indent_hanging_width > 0 ?
                        \ g:pymode_indent_hanging_width : &shiftwidth)
            return indent(parlnum) + l:indent_width
        endif

    endif

    " Examine this line
    let thisline = getline(a:lnum)
    let thisindent = indent(a:lnum)

    " If the line starts with 'elif' or 'else', line up with 'if', 'elif', or
    " 'except'
    if thisline =~ '^\s*\(elif\|else\)\>'
        let bslnum = s:BlockMatcher(a:lnum, '^\s*\(if\|elif\|except\)\>')
        if bslnum > 0
            return indent(bslnum)

        else
            return -1

        endif
    endif

    " If the line starts with 'except' or 'finally', line up with 'try'
    " or 'except'
    if thisline =~ '^\s*\(except\|finally\)\>'
        let bslnum = s:BlockMatcher(a:lnum, '^\s*\(try\|except\)\>')
        if bslnum > 0
            return indent(bslnum)

        else
            return -1

        endif
    endif

    " Examine previous (first non blank) line
    let plstartnum = a:lnum - 1 " previous line starting number
    " http://vimdoc.sourceforge.net/htmldoc/eval.html#prevnonblank()
    let plnum = prevnonblank(plstartnum) " previous (first non blank) line number
    let pline = getline(plnum) "previous (first non blank) actual line (string)
    let plbuffer = 1 " buffer lines
    let sslnum = s:StatementStart(plnum) " statement start line number
    let ssline = getline(sslnum) " statement start actual line (string)
    let sslindent = indent(sslnum) "statement start indent

    " If this line is explicitly joined, find the first indentation that is a
    " multiple of four and will distinguish itself from next logical line.
    if pline =~ '\\$'
        let maybe_indent = sslindent + &sw
        let control_structure = '^\s*\(if\|while\|for\s.*\sin\|except\)\s*'
        if match(ssline, control_structure) != -1
            " add extra indent to avoid E125
            return maybe_indent + &sw
        else
            " control structure not found
            return maybe_indent
        endif
    endif

    " If the previous line ended with a colon and is not a comment, indent
    " relative to statement start.
    if pline =~ '^[^#]*:\s*\(#.*\)\?$'
        return sslindent + &sw

    endif

    " If the previous line was a stop-execution statement or a pass
    if ssline =~ '^\s*\(break\|continue\|raise\|return\|pass\)\>'
        if thisindent == 0
            return sslindent - &sw

        elseif thisindent > sslindent - &sw
            " See if the user has already dedented
            " If not, recommend one dedent
            return sslindent - &sw

        endif

        " Otherwise, trust the user
        return -1
    endif

    " We are more than BUFFER blank lines from the previous (first non blank)
    " line
    if (plstartnum - plbuffer) > plnum
        if thisindent != 0
            " trust the user
            return -1

        else
            " we failed all the other checks so let's line up with the next
            " (non blank) line
            let nlnum = nextnonblank(a:lnum)
            " http://vimdoc.sourceforge.net/htmldoc/eval.html#nextnonblank()
            let nlindent = indent(nlnum)

            if nlindent > 0
                return nlindent

            else
                " trust the user
                return -1

            endif
        endif

    else
        " We are within BUFFER blank lines from the previous (first non blank)
        " line but we don't want to mess with the indent if the user has alreay
        " changed it (eg, you hit I and then indent back one (go from 3 tabs
        " to 2 tabs) and hit enter you don't want to reset to 3 tabs
        if thisindent != 0
            " trust the user
            return -1

        endif
    endif

    " In all other cases, line up with the start of the previous statement.
    return indent(sslnum)
endfunction

