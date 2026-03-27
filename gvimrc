"set guifont=Courier_New:h10:cANSI
" use the default apple monospace font, these are the different weights:
" https://developer.apple.com/documentation/appkit/nsfontweight
"set guifont=-monospace-Light:h11
set guifont=Monospace:p11


augroup gvimrc
  " reset all autocmds for this file in case it is reloaded
  autocmd!
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Save/restore the window size
"
" based off of this script:
" http://vim.wikia.com/wiki/Restore_screen_size_and_position
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" k tries to keep the window the same size but it leads to a funny quirk where
" the windows get progressively one line shorter as they get closed down. This
" makes it so the gui will grow by the tabs size. I'll see if that fixes the
" problem, if it doesn't I'll try and compensate by checking if tabs are open
" and compensating for the height
set guioptions-=k


" set this for the size to be saved at all
if !exists("g:screen_size_restore")
  let g:screen_size_restore = 1
endif


function! ScreenFilename()
  return $VIMTEMP . '/vimsize.txt'
endfunction


function! ScreenRestore()
  " Restore window size (columns and lines) and position
  " from values stored in vimsize file.
  " Must set font first so columns and lines are based on font size
  if g:screen_size_restore
    let f = ScreenFilename()
    if g:screen_size_restore
      if filereadable(f)
        for line in readfile(f)
          "echom line
          silent! execute line
        endfor
      endif
    endif
  endif
endfunction


function! ScreenSave()
  " Save window size and position if it has changed
  if g:screen_size_restore
    let lines = []
    let line = 'set columns=' . &columns . ' lines=' . &lines
    call add(lines, line)
    let f = ScreenFilename()
    call writefile(lines, f)
  endif
endfunction


augroup gvimrc
  autocmd VimEnter * call ScreenRestore()
  autocmd VimResized * call ScreenSave()
augroup END

