"set guifont=Courier_New:h10:cANSI
" use the default apple monospace font, these are the different weights:
" https://developer.apple.com/documentation/appkit/nsfontweight
set guifont=-monospace-Light:h10:cANSI

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

function! ScreenFilename()
  let vim_instance = (g:screen_size_by_vim_instance==1) ? (v:servername) : 'GVIM'
  if has("win32")
    return $VIMTEMP . '\vimsize_' . vim_instance . '.txt'
  else
    return $VIMTEMP . '/vimsize_' . vim_instance . '.txt'
  endif
endfunction

function! ScreenRestore()
  " Restore window size (columns and lines) and position
  " from values stored in vimsize file.
  " Must set font first so columns and lines are based on font size

  " for comparison, get default values, and we will only save values if they
  " have changed
  let s:screen_size_ocolumns = &columns
  let s:screen_size_olines = &lines
  let s:screen_size_ox = getwinposx()<0?0:getwinposx()
  let s:screen_size_oy = getwinposy()<0?0:getwinposy()
  let f = ScreenFilename()
  if g:screen_size_restore || g:screen_size_restore_pos
    if filereadable(f)
      for line in readfile(f)
        let sizepos = split(line)
        if len(sizepos) >= 3
          if sizepos[0] == "size"
            silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
          endif
          if sizepos[0] == "pos"
            silent! execute "winpos ".sizepos[1]." ".sizepos[2]
          endif
        endif
      endfor
    endif
  endif
endfunction

function! ScreenSave()
  " Save window size and position if it has changed
  let lines = []
  if g:screen_size_restore
    let s:screen_size_columns = &columns
    let s:screen_size_lines = &lines
    if (s:screen_size_columns != s:screen_size_ocolumns) || (s:screen_size_lines != s:screen_size_olines)
      let data = 'size ' . s:screen_size_columns . ' ' . s:screen_size_lines
      call add(lines, data)
    endif
  endif
  if g:screen_size_restore_pos
    let s:screen_size_x = getwinposx()<0?0:getwinposx()
    let s:screen_size_y = getwinposy()<0?0:getwinposy()
    if (s:screen_size_x != s:screen_size_ox) || (s:screen_size_y != s:screen_size_oy)
      let data = 'pos ' . s:screen_size_x . ' ' . s:screen_size_y
      call add(lines, data)
    endif
  endif
  if len(lines) > 0
    let f = ScreenFilename()
    call writefile(lines, f)
  endif
endfunction

autocmd VimEnter * if g:screen_size_restore == 1 | call ScreenRestore() | endif
autocmd VimLeavePre * if g:screen_size_restore == 1 | call ScreenSave() | endif


" http://www.utf8-chartable.de/unicode-utf8-table.pl?start=8192
"set listchars=tab:‧\ ,space:‧,eol:․,trail:‧,extends:‧,precedes:‧
"set listchars=tab:‧\ ,leadmultispace:‧\ \ \ ,eol:․,trail:‧,extends:‧,precedes:‧
set listchars=tab:܁\ ,leadmultispace:܁\ \ \ ,eol:․,trail:܁,extends:܁,precedes:܁
set list


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
  if len(l:syntax_group) > 0
    let l:syntax_info = l:syntax_name . ' (' . l:syntax_group . ')'
  else
    let l:syntax_info = l:syntax_name
  endif
  return l:syntax_info

endfunction

"hi User1 guibg=#ECF7FF guifg=#A0A0A0
set laststatus=2
set statusline=   " clear the statusline for when vimrc is reloaded
set statusline+=%1* " switch to User1 highlight
set statusline+=%{repeat('\ ',LineNumberBuffer())}
"set statusline+=%f\                          " file name
set statusline+=[%n]\ %.80F\                  " buffer number and file (max 80 chars of path)
set statusline+=%h%m%r%w                     " flags
set statusline+=[%{strlen(&ft)?&ft:'none'},\  " filetype
"set statusline+=[%y,\  " filetype
set statusline+=%{strlen(&fenc)?&fenc:&enc},\  " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
"set statusline+=%-2.10{v:register}
set statusline+=%{v:register}\ 
set statusline+=%{SyntaxInfo()}
set statusline+=%15.15(%c\ %l/%L%)\   "cursor_column current_line/total_lines


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set the colort column
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists('+colorcolumn')
  " the columns should be 1 and 41 after the set textwidth setting
  set colorcolumn=+1,+41

endif

