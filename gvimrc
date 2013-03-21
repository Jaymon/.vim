set guifont=Courier_New:h10:cANSI

" based off of this script:
" http://vim.wikia.com/wiki/Restore_screen_size_and_position
"
" This seems to work, the problem is it will set a certain size for the big
" monitor, and then that will be huge for the laptop screen, but it's better
" than the full size the GUIEnter was giving me
let g:screen_size_restore_pos = (exists("g:screen_size_restore_pos")) ? g:screen_size_restore_pos : 1
let g:screen_size_by_vim_instance = (exists("g:screen_size_by_vim_instance")) ? g:screen_size_by_vim_instance : 1

function! ScreenFilename()
  if has("win32")
    return $TEMP . '\vimsize'
  else
    return '/tmp/vimsize'
  endif
endfunction

function! ScreenRestore()
  " Restore window size (columns and lines) and position
  " from values stored in vimsize file.
  " Must set font first so columns and lines are based on font size.
  let f = ScreenFilename()
  if g:screen_size_restore_pos && filereadable(f)
    let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
    for line in readfile(f)
      let sizepos = split(line)
      if len(sizepos) == 5 && sizepos[0] == vim_instance
        silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
        silent! execute "winpos ".sizepos[3]." ".sizepos[4]
        return
      endif
    endfor
  endif
endfunction

function! ScreenSave()
  " Save window size and position.
  if g:screen_size_restore_pos
    let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
    let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
          \ (getwinposx()<0?0:getwinposx()) . ' ' .
          \ (getwinposy()<0?0:getwinposy())
    let f = ScreenFilename()
    if filereadable(f)
      let lines = readfile(f)
      call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
      call add(lines, data)
    else
      let lines = [data]
    endif
    call writefile(lines, f)
  endif
endfunction

autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif

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
  set listchars=tab:˱\ ,eol:˲,trail:˱,extends:˱,precedes:˱
endif
set list
" the 2 lines work to match space, but I don't like it since it messes with
" highlight current line, I guess I just have to hope for space: support in
" listchars, see https://groups.google.com/forum/?fromgroups=#!topic/vim_dev/dIQHjW1g92s
" http://stackoverflow.com/questions/1675688/make-vim-show-all-white-spaces-as-a-character
" set conceallevel=2 concealcursor=nv
" autocmd BufWinEnter * syntax match NonText / / conceal cchar=˻
