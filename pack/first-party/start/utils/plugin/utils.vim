
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
" auto-discover the file's actual indentation
"
" This will infer the indent of the file based on the first N lines of the
" file, the idea is that it will check the indent of each of the first N lines
" of the file and find the minimum tabstop count and then set tabstop to that
"
" I've wanted to do this for a long time but never bothered to figure out how
" to do it because Vim plugins are often inscrutable and I wasn't sure how to
" approach the problem.
"
" https://psy.swansea.ac.uk/staff/carter/vim/vim_indent.htm
"##############################################################################
function! s:Min(a, b)
  if a:a < a:b
    return a:a
  else
    return a:b
  endif
endfunction

" Goes through `lines` of the current file to decide the actual tabstop value
" of the file. Also decide if tabs or spaces are in use. This returns a list
" where index 0 is the tabstop value and index 1 is 1 if tabs are in use, 0
" otherwise
function! s:InferIndentation(lines=100)
  let l:max_lines = s:Min(a:lines, line('$'))
  let l:file_indent = 0
  let l:uses_tabs = 0

  for i in range(1, l:max_lines)
    let l:line_indent = indent(i)
    if l:line_indent > 0
      if l:file_indent == 0
        let l:file_indent = l:line_indent

      else
        let l:file_indent = s:Min(l:line_indent, l:file_indent)

      endif

      if getline(i) =~ '^\t'
        let l:uses_tabs = 1

      else
        let l:uses_tabs = 0

      endif

    endif

  endfor

  return [l:file_indent, l:uses_tabs]
endfunction


" This function is run after any file is loaded
function! s:OverrideIndentation()

  let l:result = s:InferIndentation()
  let l:file_indent = l:result[0]
  let l:uses_tabs = l:result[1]

  if l:file_indent > 0 && l:file_indent != &tabstop
    execute "set tabstop=" . l:file_indent
    execute "set softtabstop=" . &tabstop
    execute "set shiftwidth=" . &tabstop

  endif

  if l:uses_tabs > 0
    set noexpandtab

  endif

endfunction


augroup utils
  autocmd!

  " Run after all other ftplugins (the nested keyword)
  autocmd FileType * nested call s:OverrideIndentation()
augroup END
"##############################################################################

