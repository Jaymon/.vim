" Python-mode motion functions


" Jay has completely changed this method (9-18-2024)
fun! pymode#motion#move(pattern, flags, ...) "{{{
	" flags:
	" * W: Do not wrap around the end of the file (search only in the direction
	" without wrapping).
	" * s: Allow the match to start where the cursor is.
	" * b: Search backward.
    let [lnum, column] = searchpos(a:pattern, a:flags . 'sW')
	if lnum == 0
		" there was no match so move cursor to either the bottom or top of the
		" file
		if stridx(a:flags, 'b') != -1
			let lnum = 1

		else
			let lnum = line('$')

		endif

		let column = 1
		" I'm not sure why this needs to call cursor to move the cursor while
		" the else block doesn't
		call cursor(lnum, column)

	else
		" v:count1 is a special variable that holds the count value for a
		" command, but with a default value of 1 when no count is given.
		" When you provide a count before a command (e.g., 5j to move down
		" 5 lines), v:count1 will hold that value (5 in this case).
		let cnt = v:count1 - 1
		let indent = indent(lnum)

		while cnt && lnum
			let [lnum, column] = searchpos(a:pattern, a:flags . 'W')
			if indent(lnum) == indent
				let cnt = cnt - 1

			endif
		endwhile
	endif

	"echom 'line: '.lnum.', column: '.column
    return [lnum, column]
endfunction "}}}


fun! pymode#motion#vmove(pattern, flags) range "{{{
    call cursor(a:lastline, 0)
    let end = pymode#motion#move(a:pattern, a:flags)
    call cursor(a:firstline, 0)
    normal! v
    call cursor(end)
endfunction "}}}


fun! pymode#motion#pos_le(pos1, pos2) "{{{
    return ((a:pos1[0] < a:pos2[0]) || (a:pos1[0] == a:pos2[0] && a:pos1[1] <= a:pos2[1]))
endfunction "}}}

fun! pymode#motion#select(first_pattern, second_pattern, inner) "{{{
    let cnt = v:count1 - 1
    let orig = getpos('.')[1:2]
    let posns = s:BlockStart(orig[0], a:first_pattern, a:second_pattern)
    if getline(posns[0]) !~ a:first_pattern && getline(posns[0]) !~ a:second_pattern
        return 0
    endif
    let snum = posns[0]
    let enum = s:BlockEnd(posns[1], indent(posns[1]))
    while cnt
        let lnum = search(a:second_pattern, 'nW')
        if lnum
            let enum = s:BlockEnd(lnum, indent(lnum))
            call cursor(enum, 1)
        endif
        let cnt = cnt - 1
    endwhile
    if pymode#motion#pos_le([snum, 0], orig) && pymode#motion#pos_le(orig, [enum+1, 0])
        if a:inner
            let snum = posns[1] + 1
        endif

        call cursor(snum, 1)
        normal! V
        call cursor(enum, len(getline(enum)))
    endif
endfunction "}}}

fun! pymode#motion#select_c(pattern, inner) "{{{
    call pymode#motion#select(a:pattern, a:pattern, a:inner)
endfunction "}}}

fun! s:BlockStart(lnum, first_pattern, second_pattern) "{{{
    let lnum = a:lnum + 1
    let indent = 100
    while lnum
        let lnum = prevnonblank(lnum - 1)
        let test = indent(lnum)
        let line = getline(lnum)
        " Skip comments, deeper or equal lines
        if line =~ '^\s*#' || test >= indent
            continue
        endif
        let indent = indent(lnum)

        " Indent is strictly less at this point: check for def/class/@
        if line =~ a:first_pattern || line =~ a:second_pattern
            while getline(lnum-1) =~ a:first_pattern
                let lnum = lnum - 1
	    endwhile
	    let first_pos = lnum
	    while getline(lnum) !~ a:second_pattern
                let lnum = lnum + 1
            endwhile
	    let second_pos = lnum
            return [first_pos, second_pos]
        endif
    endwhile
    return [0, 0]
endfunction "}}}


fun! s:BlockEnd(lnum, ...) "{{{
    let indent = a:0 ? a:1 : indent(a:lnum)
    let lnum = a:lnum
    while lnum
        let lnum = nextnonblank(lnum + 1)
        if getline(lnum) =~ '^\s*#' | continue
        elseif lnum && indent(lnum) <= indent
            return prevnonblank(lnum - 1)
        endif
    endwhile
    return line('$')
endfunction "}}}
" vim: fdm=marker:fdl=0
