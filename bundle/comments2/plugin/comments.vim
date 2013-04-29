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

" function to comment line in normal mode
function! CommentLine()
  let l:comment_bits = split(&commentstring, "%s")

  if len(l:comment_bits) == 1
    execute ":silent! normal 0i" . l:comment_bits[0] . "\<ESC>==\<down>^"

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
    execute ":silent! normal :nohlsearch\<CR>:s/" . escape(l:comment_bits[0], '\\/.*$^~[]') . "//\<CR>:nohlsearch\<CR>=="

  else
    let l:start = l:comment_bits[0]
    let l:stop = l:comment_bits[1]
    execute ":silent! normal :nohlsearch\<CR>:s/". escape(l:start, '\\/.*$^~[]') . "//\<CR>=="
    execute ":silent! normal :nohlsearch\<CR>:s/" . escape(l:stop, '\\/.*$^~[]') . "//\<CR>=="

  endif

endfunction

" function to range comment lines in visual mode
function! RangeCommentLine()
  let l:comment_bits = split(&commentstring, "%s")

  if len(l:comment_bits) == 1
    execute ":silent! normal :s/\\S/" . escape(l:comment_bits[0], '\\/.*$^~[]') . "\\0/\<CR>:nohlsearch<CR>=="

  else
    let l:start = l:comment_bits[0]
    let l:stop = l:comment_bits[1]
    execute ":silent! normal :s/\\(\\S.*$\\)/" . escape(l:start, '\\/.*$^~[]') . "\\1" . escape(l:stop, '\\/.*$^~[]') . "/\<CR>:nohlsearch\<CR>=="
    " execute ":normal :nohlsearch\<CR>:s/\\([^" . escape(l:start, '\\/.*$^~[]') . "]*\\)\\(" . escape(l:start, '\\/.*$^~[]') . ".*" . escape(l:stop, '\\/.*$^~[]') . "\\)/\\1" . escape(l:stop, '\\/.*$^~[]') . "\\2/\<CR>:s/\\([^[:blank:]]\\+\\)/" . escape(l:start, '\\/.*$^~[]') . "\\1/\<CR>:nohlsearch\<CR>=="

  endif

endfunction

" function to range un-comment lines in visual mode
function! RangeUnCommentLine()
  let l:comment_bits = split(&commentstring, "%s")

  if len(l:comment_bits) == 1
    execute ":silent! normal :s/" . escape(l:comment_bits[0], '\\/.*$^~[]') . "//\<CR>:nohlsearch\<CR>=="

  else
    let l:start = l:comment_bits[0]
    let l:stop = l:comment_bits[1]
    execute ":silent! normal :nohlsearch\<CR>:s/" . escape(l:start, '\\/.*$^~[]') . "//\<CR>=="
    execute ":silent! normal :nohlsearch\<CR>:s/" . escape(l:stop, '\\/.*$^~[]') . "//\<CR>=="

  endif

endfunction

