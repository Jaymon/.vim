"set guifont=Courier_New:h10:cANSI
" use the default apple monospace font, these are the different weights:
" https://developer.apple.com/documentation/appkit/nsfontweight
set guifont=-monospace-Light:h10:cANSI


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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Whitespace delims
" http://www.utf8-chartable.de/unicode-utf8-table.pl?start=8192
"
" Characters until 12-3-2024: ‧․
" 
" Current characters: \u0701 and \u0702
"   https://www.compart.com/en/unicode/category/Po
"   https://www.compart.com/en/unicode/scripts/Syrc
"set listchars=tab:‧\ ,space:‧,eol:․,trail:‧,extends:‧,precedes:‧
"set listchars=tab:‧\ ,leadmultispace:‧\ \ \ ,eol:․,trail:‧,extends:‧,precedes:‧
"set listchars=tab:܁\ ,leadmultispace:܁\ \ \ ,eol:․,trail:܁,extends:܁,precedes:܁
set listchars=tab:܁\ ,leadmultispace:܁\ \ \ ,eol:܂,trail:܁,extends:܁,precedes:܁
set list
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set the status line
" :help statusline
" http://learnvimscriptthehardway.stevelosh.com/chapters/17.html
" http://stackoverflow.com/questions/5375240/a-more-useful-statusline-in-vim
" http://got-ravings.blogspot.com/2008/08/vim-pr0n-making-statuslines-that-own.html
" http://vim.wikia.com/wiki/Writing_a_valid_statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" this function is used to figure out how much left side space buffering is
" needed to position the start of the status line at the end of the line
" number gutter
function! LineNumberBuffer()
  let l:line_number_len = len(line('$')) + 1
  " not sure why this needs the +1 here, but it does
  return l:line_number_len > &numberwidth ? l:line_number_len + 1 : &numberwidth + 1

endfunction

" Get a string of the syntax rule and any linked syntax rule
function! SyntaxInfo()
  " https://stackoverflow.com/a/36993989
  let l:s = synID(line('.'),col('.'),1)
  let l:syntax_name = synIDattr(s, 'name')
  let l:syntax_group = synIDattr(synIDtrans(s), 'name')

  if len(l:syntax_group) > 0 && l:syntax_name !=? l:syntax_group
    let l:syntax_info = l:syntax_name . ' (' . l:syntax_group . ')'

  else
    let l:syntax_info = l:syntax_name

  endif

  return l:syntax_info

endfunction

set laststatus=2
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%1* " switch to User1 highlight
set statusline+=%{repeat('\ ',LineNumberBuffer())}
"set statusline+=%f\                            " file name
set statusline+=[%n]\ %.80F\                    " buffer number and file (max 80 chars of path)
set statusline+=%h%m%r%w                        " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},\    " filetype
"set statusline+=[%y,\  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc},\   " encoding
set statusline+=%{&fileformat}]                 " file format
set statusline+=%=                              " right align
"set statusline+=%-2.10{v:register}
set statusline+=%{v:register}\ 
set statusline+=%{SyntaxInfo()}
set statusline+=%15.15(%c\ %l/%L%)\             " cursor_column current_line/total_lines
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the color column
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('+colorcolumn')
  " the columns should be 1 and 41 after the set textwidth setting
  set colorcolumn=+1,+41

endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

