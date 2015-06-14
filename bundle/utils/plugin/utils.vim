
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
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  else
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>
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
      else
        echo "OS Not currently supported"
        " TODO: wrapping this in the has('gui') should keep this from firing in linux, maybe?
        " this should work, but I almost never have a gui in Linux computers
        "exec ":silent !xdg-open " . l:uri
      endif
    endif
  endif
endfunction

map <silent> <leader>b :call LaunchBrowser()<CR>:redraw!<CR>
"##############################################################################
