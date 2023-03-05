
" Exit if already loaded
if exists("g:loaded_utils")
  finish
endif
let g:loaded_utils="v0.1"


"##############################################################################
" allows * and # to search current selection just like it searchs for current word under cursor
" http://vimingwithbuttar.googlecode.com/hg/.vimrc
"##############################################################################
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == '?' " backwards
    execute "normal ?" . l:pattern . "^M"
  else " forwards
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

vnoremap <silent> * :call VisualSearch('/')<CR>:set hlsearch<CR>
vnoremap <silent> # :call VisualSearch('?')<CR>:set hlsearch<CR>
"##############################################################################


"##############################################################################
" this will launch the default browser window with the first url found on line
" http://waoewaoe.wordpress.com/2009/05/05/open-a-website-in-a-browser-from-commandline/
" http://vim.wikia.com/wiki/Open_a_web-browser_with_the_URL_in_the_current_line
"##############################################################################
function! LaunchBrowser()
  if has('gui')
    let l:uri = matchstr(getline("."), 'https\?:\/\/\S\+\c')
    let l:uri = shellescape(l:uri, 1)
    if l:uri != ""
      if has("win32")
        " if urls with & fail, we'll need to escape them with ^
        " https://github.com/copiousfreetime/launchy/issues/5
        " http://vim.wikia.com/wiki/Execute_external_programs_asynchronously_under_Windows
        " !start didn't work, there needs to be a space between the ! and the start
        exec ":silent ! start \"\" " . l:uri

      elseif has("mac")
        exec ":silent !open " . l:uri

      elseif has("unix")
        " this should work, but I almost never have a gui in Linux computers
        " so I've never tested it
        exec ":silent !xdg-open " . l:uri

      else
        echo "OS Not currently supported"

      endif
    endif
  endif
endfunction

map <silent> <leader>b :call LaunchBrowser()<CR>:redraw!<CR>
"##############################################################################


"##############################################################################
" This will infer the indent of the file based on the first N lines of the
" file, the idea is that it will check the indent of each of the first N lines
" of the file and find the minimum tabstop count and then set tabstop to that
"
" I've wanted to do this for a long time but never bothered to figure out how
" to do it because Vim plugins are often inscrutable and I wasn't sure how to
" approach the problem.
"##############################################################################
function! Min(a, b)
  if a:a < a:b
    return a:a
  else
    return a:b
  endif
endfunction


" If you set this to 2 then it will basically always return 2, which is less
" than ideal
function! InferIndent(soft_tab_stop)
  let l:max_lines = Min(100, line('$'))
  let l:file_indent = a:soft_tab_stop

  for i in range(1, l:max_lines)
    let l:line_indent = indent(i)
    if l:line_indent > 0
      let l:file_indent = Min(l:line_indent, l:file_indent)
    endif
  endfor

  return l:file_indent
endfunction


execute "set tabstop=" . InferIndent(&tabstop)
execute "set softtabstop=" . &tabstop
execute "set shiftwidth=" . &tabstop

