set guifont=Courier_New:h10:cANSI

" based off of this script:
" http://vim.wikia.com/wiki/Restore_screen_size_and_position
"
" This seems to work, the problem is it will set a certain size for the big
" monitor, and then that will be huge for the laptop screen, but it's better
" than the full size the GUIEnter was giving me on Mac

" set this for the size to be saved at all
let g:screen_size_restore = (exists("g:screen_size_restore")) ? g:screen_size_restore : 1
" set this to restore the screen position of the window, not just the size
let g:screen_size_restore_pos = (exists("g:screen_size_restore_pos")) ? g:screen_size_restore_pos : 0
" set this to restore by window name instead of one global size for all windows
let g:screen_size_by_vim_instance = (exists("g:screen_size_by_vim_instance")) ? g:screen_size_by_vim_instance : 1

" we have to call this from a function since it didn't work to set a var on
" startup on Mac OS, g:vim_instance ended up being set to ""
function! GetVimInstance()
  if !exists("g:vim_instance")
    let g:vim_instance = (g:screen_size_by_vim_instance==1) ? (v:servername) : 'GVIM'
  endif
  return g:vim_instance
endfunction

function! ScreenFilename()
  let vim_instance = GetVimInstance()
  if has("win32")
    return $VIMTEMP . '\vimsize_' . vim_instance . '.txt'
  else
    return $VIMTEMP . '/vimsize_' . vim_instance . '.txt'
  endif
endfunction

function! ScreenRestore()
  " Restore window size (columns and lines) and position
  " from values stored in vimsize file.
  " Must set font first so columns and lines are based on font size.
  let f = ScreenFilename()
  if g:screen_size_restore && filereadable(f)
    for line in readfile(f)
      let sizepos = split(line)
      if len(sizepos) >= 2
        silent! execute "set columns=".sizepos[0]." lines=".sizepos[1]
        if g:screen_size_restore_pos && (len(sizepos) >= 4)
          silent! execute "winpos ".sizepos[2]." ".sizepos[3]
        endif
        return
      endif
    endfor
  endif
endfunction

function! ScreenSave()
  " Save window size and position.
  if g:screen_size_restore
    let data = '' . &columns . ' ' . &lines . ' ' .
          \ (getwinposx()<0?0:getwinposx()) . ' ' .
          \ (getwinposy()<0?0:getwinposy())
    let f = ScreenFilename()
    let lines = [data]
    call writefile(lines, f)
  endif
endfunction

autocmd VimEnter * if g:screen_size_restore == 1 | call ScreenRestore() | endif
autocmd VimLeavePre * if g:screen_size_restore == 1 | call ScreenSave() | endif

"set columns=160 lines=65
" we do our best to set cols to half the width and lines to about 2/3 height
" http://vim.1045645.n5.nabble.com/Setting-width-to-half-screen-size-td1172185.html
" TODO: make work in macvim
" autocmd GUIEnter * let &columns = 9999 | let &columns = &columns/3 + &columns/4
" autocmd GUIEnter * let &lines = 999 | let &lines = &lines/2 + &lines/3

if has("win32")
  " http://www.utf8-chartable.de/unicode-utf8-table.pl?start=688
  set listchars=tab:˻\ ,eol:˼,trail:˻,extends:˻,precedes:˻
else
  " http://www.utf8-chartable.de/unicode-utf8-table.pl?start=8192
  set listchars=tab:‧\ ,eol:․,trail:‧,extends:‧,precedes:‧
endif
set list
" the 2 lines work to match space, but I don't like it since it messes with
" highlight current line, I guess I just have to hope for space: support in
" listchars, see https://groups.google.com/forum/?fromgroups=#!topic/vim_dev/dIQHjW1g92s
" http://stackoverflow.com/questions/1675688/make-vim-show-all-white-spaces-as-a-character
" set conceallevel=2 concealcursor=nv
" autocmd BufWinEnter * syntax match NonText / / conceal cchar=˻
