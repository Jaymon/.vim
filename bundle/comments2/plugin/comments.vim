" Quickly comment out chunks of code
"
" for the escaping:
" http://superuser.com/questions/320398/how-to-properly-vim-escape-a-variable-register
" http://jeetworks.org/node/86
"
" links that helped me:
" http://learnvimscriptthehardway.stevelosh.com/chapters/27.html
" http://learnvimscriptthehardway.stevelosh.com/chapters/19.html
" http://www.ibm.com/developerworks/linux/library/l-vim-script-1/
" http://stackoverflow.com/questions/1162611/vim-getting-the-current-value-of-vim-foldmarker
" http://www.mail-archive.com/vim@vim.org/msg00178.html
" http://stackoverflow.com/questions/11176159/vim-go-to-start-end-of-visual-selection
"
" Handy :help
" :help function-range-example

" Exit if already loaded
if exists("g:loaded_comments_plugin")
  finish
endif

let g:loaded_comments_plugin="v3.1"

if !exists("g:comments_map_keys")
  let g:comments_map_keys = 1
endif

if g:comments_map_keys
  " key-mappings for comment/uncomment line in normal mode
  noremap  <silent> <C-C> :call Commentify()<CR>
  " key-mappings for range comment/uncomment lines in visual <Shift-V> mode
  vnoremap  <silent> <C-C> :call RangeCommentify()<CR>
endif

" escape the input for using in exec search queries
function! EscapeInput(input)
  return escape(a:input, '\\/.*$^~[]')
endfunction

" x out any current comments (we do this by changing things */ to * /)
" (this will fail on multiline comments that are only one char, not sure what language has that though)
function! EscapeComment(start, stop)
    execute ":silent! normal! :'<,'>s/" . EscapeInput(a:start) . "/" . EscapeInput(a:start[0]) . " " . EscapeInput(a:start[1]) ."/\<ESC>"
    execute ":silent! normal! :'<,'>s/" . EscapeInput(a:stop) . "/" . EscapeInput(a:stop[0]) . " " . EscapeInput(a:stop[1]) ."/\<ESC>"
endfunction

" basically unperform the EscapeComment operation
function! UnescapeComment(start, stop)
    execute ":silent! normal! :'<,'>s/" . EscapeInput(a:start[0]) . " " . EscapeInput(a:start[1]) ."/" . EscapeInput(a:start) . "/\<ESC>"
    execute ":silent! normal! :'<,'>s/" . EscapeInput(a:stop[0]) . " " . EscapeInput(a:stop[1]) ."/" . EscapeInput(a:stop) . "/\<ESC>"
endfunction

" comment a non commented line, uncomment a commented out line
function! Commentify()
  let l:comment_bits = split(&commentstring, "%s")
  if match(getline("."), "^\\s*" . EscapeInput(l:comment_bits[0])) == 0
    call UnCommentLine()
  else
    call CommentLine()
  endif

endfunction

" function to comment line in normal mode
function! CommentLine()
  let l:comment_bits = split(&commentstring, "%s")

  if len(l:comment_bits) == 1
    execute ":silent! normal! 0i" . l:comment_bits[0] . "\<ESC>\<down>"

  else
    let l:start = l:comment_bits[0]
    let l:stop = l:comment_bits[1]
    execute ":silent! normal! 0i" . l:start . "\<ESC>$a" . l:stop ."\<ESC>==\<down>^"

  endif

endfunction

" function to un-comment line in normal mode
function! UnCommentLine()
  let l:comment_bits = split(&commentstring, "%s")

  if len(l:comment_bits) == 1
    execute ":silent! normal! :nohlsearch\<CR>:s/" . EscapeInput(l:comment_bits[0]) . "//\<CR>:nohlsearch\<CR>=="

  else
    let l:start = l:comment_bits[0]
    let l:stop = l:comment_bits[1]
    execute ":silent! normal! :nohlsearch\<CR>:s/" . EscapeInput(l:start) . "//\<CR>"
    execute ":silent! normal! :nohlsearch\<CR>:s/" . EscapeInput(l:stop) . "//\<CR>"

  endif

endfunction

" comment a non-commented range, or uncomment a commented range
" For some reason, this didn't work when I tried to break comment/uncomment
" into their own functions that this function called, so this one is combined
" and messy while the Commentify is much cleaner
function! RangeCommentify() range
  let l:comment_bits = split(&commentstring, "%s")
  "let [lnum1, col1] = getpos("'<")[1:2]
  let l:first_line = getline(a:firstline)[getpos("'<")[2] - 1:]
  
  if match(l:first_line, "^\\s*" . EscapeInput(l:comment_bits[0])) == 0
    " UNCOMMENT
    if len(l:comment_bits) == 1
      execute ":silent! normal! :" . a:firstline . "," . a:lastline . "s/" . EscapeInput(l:comment_bits[0]) . "//\<CR>:nohlsearch\<CR>=="
    else
      let l:start = l:comment_bits[0]
      let l:stop = l:comment_bits[1]

      " restore any comment strings
      execute ":silent! normal! :nohlsearch\<CR>:'<,'>s/" . EscapeInput(l:start) . "//\<CR>"
      execute ":silent! normal! :nohlsearch\<CR>:'<,'>s/" . EscapeInput(l:stop) . "//\<CR>"
      call UnescapeComment(l:start, l:stop)
    endif
  else
    " COMMENT
    if len(l:comment_bits) == 1
      execute ":silent! normal! \<ESC>`<i" . l:comment_bits[0] . "\<ESC>"
      execute ":silent! normal! :" . (a:firstline + 1). "," . a:lastline . "s/^/" . EscapeInput(l:comment_bits[0]) . "/\<CR>:nohlsearch\<CR>\<down>"
    else
      let l:start = l:comment_bits[0]
      let l:stop = l:comment_bits[1]

      call EscapeComment(l:start, l:stop)
      execute ":silent! normal! \<ESC>`<i" . l:start . "\<ESC>`>a" . l:stop . "\<ESC>"
    endif
  endif

endfunction

