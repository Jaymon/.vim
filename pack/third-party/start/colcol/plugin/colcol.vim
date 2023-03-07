vim9script
###############################################################################
# Add a color column on demand at cursor location
#
# via: 
# * https://github.com/habamax/.vim/blob/9c134346affce6e5166fcaac39c58ef3960ca563/vimrc#L116-L146
# * https://github.com/habamax/.vim#toggle-colorcolumn-at-cursor-position
#
###############################################################################


# toggle colorcolumn at cursor position
# set vartabstop accordingly
def ToggleCC(all: bool = false)
    if all
        b:cc = &cc ?? get(b:, "cc", "80")
        &cc = empty(&cc) ? b:cc : ""
    else
        var col = virtcol('.')
        var cc = split(&cc, ",")->map((_, v) => str2nr(v))
        if index(cc, col) == -1
            exe "set cc=" .. cc->add(col)->sort('f')->map((_, v) => printf("%s", v))->join(',')
        else
            exe $"set cc-={col}"
        endif
    endif
    var cc = split(&cc, ",")->map((_, v) => str2nr(v))
    if len(cc) > 1 || len(cc) == 1 && cc[0] < 60
        setl vsts&
        var shift = 1
        for v in cc
            if v == 1 | continue | endif
            exe $"set vsts+={v - shift}"
            shift = v
        endfor
        exe $"setl vsts+={&sw}"
    else
        setl vsts&
    endif
enddef

# \c will toggle the color column off and on
nnoremap <leader>c <ScriptCmd>ToggleCC()<CR>

# \C will toggle all set color columns off
nnoremap <leader>C <ScriptCmd>ToggleCC(true)<CR>

