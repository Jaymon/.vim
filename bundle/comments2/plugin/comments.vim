" TODO: 
"   1 - I would like to collapse both the setting and unsetting to just ctrl-c
"   2 - this isn't nearly as bulletproof as the plugin it replaces, but this
"   one automatically works for things like go, where the other one was
"   hardcoded, I'll fix thing as I find them, until then this is at least
"   working but it doesn't handle the comment things that are already
"   commented problem of /* and <!-- comment formats
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
"
" Handy :help
" :help function-range-example

" Exit if already loaded
if exists("loaded_comments_plugin")
  finish
endif

let loaded_comments_plugin="v3.0"

" key-mappings for comment line in normal mode
noremap  <silent> <C-C> :call CommentLine()<CR>
" key-mappings for range comment lines in visual <Shift-V> mode
vnoremap <silent> <C-C> :call RangeCommentLine()<CR>

" key-mappings for un-comment line in normal mode
noremap  <silent> <C-X> :call UnCommentLine()<CR>
" key-mappings for range un-comment lines in visual <Shift-V> mode
vnoremap <silent> <C-X> :call RangeUnCommentLine()<CR>

function! EscapeInput(input)
  return escape(a:input, '\\/.*$^~[]')
endfunction

function! EscapeComment(start, stop)
    " x out any current comments (we do this by changing things */ -> * /)
    " (this will fail on multiline comments that are only one char, not sure
    " what language has that though)
    execute ":silent! normal :'<,'>s/" . EscapeInput(a:start) . "/" . EscapeInput(a:start[0]) . " " . EscapeInput(a:start[1]) ."/\<ESC>"
    execute ":silent! normal :'<,'>s/" . EscapeInput(a:stop) . "/" . EscapeInput(a:stop[0]) . " " . EscapeInput(a:stop[1]) ."/\<ESC>"
endfunction

function! UnescapeComment(start, stop)
    execute ":silent! normal :'<,'>s/" . EscapeInput(a:start[0]) . " " . EscapeInput(a:start[1]) ."/" . EscapeInput(a:start) . "/\<ESC>"
    execute ":silent! normal :'<,'>s/" . EscapeInput(a:stop[0]) . " " . EscapeInput(a:stop[1]) ."/" . EscapeInput(a:stop) . "/\<ESC>"
endfunction

" function to comment line in normal mode
function! CommentLine()
  let l:comment_bits = split(&commentstring, "%s")

  if len(l:comment_bits) == 1
    "execute ":silent! normal 0i" . l:comment_bits[0] . "\<ESC>==\<down>^"
    execute ":silent! normal 0i" . l:comment_bits[0] . "\<ESC>\<down>"

  else
    let l:start = l:comment_bits[0]
    let l:stop = l:comment_bits[1]
    execute ":silent! normal 0i" . l:start . "\<ESC>$a" . l:stop ."\<ESC>==\<down>^"

  endif

endfunction

" function to un-comment line in normal mode
function! UnCommentLine()
  let l:comment_bits = split(&commentstring, "%s")

  if len(l:comment_bits) == 1
    execute ":silent! normal :nohlsearch\<CR>:s/" . EscapeInput(l:comment_bits[0]) . "//\<CR>:nohlsearch\<CR>=="

  else
    let l:start = l:comment_bits[0]
    let l:stop = l:comment_bits[1]
    execute ":silent! normal :nohlsearch\<CR>:s/". EscapeInput(l:start) . "//\<CR>"
    execute ":silent! normal :nohlsearch\<CR>:s/" . EscapeInput(l:stop) . "//\<CR>"

  endif

endfunction

" function to range comment lines in visual mode
function! RangeCommentLine() range
  let l:comment_bits = split(&commentstring, "%s")

  if len(l:comment_bits) == 1
    "execute ":silent! normal :" . a:firstline . "," . a:lastline . "s/\\S/" . EscapeInput(l:comment_bits[0]) . "\\0/\<CR>:nohlsearch<CR><down>"
    execute ":silent! normal :" . a:firstline . "," . a:lastline . "s/\\S/" . EscapeInput(l:comment_bits[0]) . "/\<CR>:nohlsearch<CR><down>"

  else
    let l:start = l:comment_bits[0]
    let l:stop = l:comment_bits[1]
    "execute ":silent! normal :s/\\(\\S.*$\\)/" . EscapeInput(l:start) . "\\1" . EscapeInput(l:stop) . "/\<CR>:nohlsearch\<CR>=="
    "execute ":silent! normal `<i" . l:start . "\<ESC>`>a" . l:stop . "\<ESC>\<down>"

    call EscapeComment(l:start, l:stop)
    execute ":silent! normal \<ESC>`<i" . l:start . "\<ESC>`>a" . l:stop . "\<ESC>"

  endif

endfunction

" function to range un-comment lines in visual mode
function! RangeUnCommentLine() range
  let l:comment_bits = split(&commentstring, "%s")

  if len(l:comment_bits) == 1
    execute ":silent! normal :" . a:firstline . "," . a:lastline . "s/" . EscapeInput(l:comment_bits[0]) . "//\<CR>:nohlsearch\<CR>=="

  else
    let l:start = l:comment_bits[0]
    let l:stop = l:comment_bits[1]

    " restore any comment strings
    execute ":silent! normal :nohlsearch\<CR>:'<,'>s/" . EscapeInput(l:start) . "//\<CR>"
    execute ":silent! normal :nohlsearch\<CR>:'<,'>s/" . EscapeInput(l:stop) . "//\<CR>"
    call UnescapeComment(l:start, l:stop)

  endif

endfunction

