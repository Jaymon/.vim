"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Exit if already loaded
if exists("g:loaded_indentify")
  finish
endif
let g:loaded_indentify="v0.3"


" the default tab width (how many spaces a tab should visually occupy)
"if !exists("g:indentify_tabstop")
"  let g:indentify_tabstop = &tabstop
"endif


" don't set a tabwidth smaller than this value
if !exists("g:indentify_minimum_tabstop")
  let g:indentify_minimum_tabstop = 2
endif


" How many lines to check to infer the indentation
if !exists("g:indentify_infer_lines")
  let g:indentify_infer_lines = 100
endif


" get the minimum value from `a` and `b` but don't go lower than `minimum`
function! s:Min(a, b, minimum=g:indentify_minimum_tabstop)
  if a:a < a:b
    if a:a < a:minimum
      return a:minimum

    else
      return a:a
    endif

  else
    if a:b < a:minimum
      return a:minimum

    else
      return a:b

    endif

  endif
endfunction


" Goes through `lines` of the current file to decide the actual tabstop value
" of the file. Also decide if tabs or spaces are in use. This returns a list
" where index 0 is the tabstop value and index 1 is 1 if tabs are in use, 0
" otherwise
function! s:InferIndentation(lines=g:indentify_infer_lines)
  let l:max_lines = s:Min(a:lines, line('$'))
  let l:file_indent = 0

  " keep track of how many lines start with spaces as opposed to tabs, these
  " are used to calculate if this file is considered to use tabs or spaces
  let l:spaces_count = 0
  let l:tabs_count = 0

  for i in range(1, l:max_lines)
    let l:line_indent = indent(i)
    if l:line_indent > 0
      if getline(i) =~ '^\t'
        let l:tabs_count += 1

      else
        let l:spaces_count += 1

        if l:file_indent == 0
          let l:file_indent = l:line_indent

        else
          let l:file_indent = s:Min(l:line_indent, l:file_indent)
        endif
      endif
    endif
  endfor

  return [l:file_indent, l:tabs_count > 0 && (l:tabs_count >= l:spaces_count)]
endfunction


" This function is run after any file is loaded
function! s:OverrideIndentation()
  let l:result = s:InferIndentation()
"  let l:file_indent = l:result[0]
  let l:tabstop = l:result[0]
  let l:uses_tabs = l:result[1]

  " https://tedlogan.com/techblog3.html
  "
  " tabstop Set tabstop to tell vim how many columns a tab counts for. Linux
  " kernel code expects each tab to be eight columns wide. Visual Studio
  " expects each tab to be four columns wide.  This is the only command here
  " that will affect how existing text displays.
  "
  " expandtab When expandtab is set, hitting Tab in insert mode will produce
  " the appropriate number of spaces.
  "
  " shiftwidth Set shiftwidth to control how many columns text is indented with
  " the reindent operations (<< and >>) and automatic C-style indentation.
  "
  " softtabstop Set softtabstop to control how many columns vim uses when you
  " hit Tab in insert mode. If softtabstop is less than tabstop and expandtab
  " is not set, vim will use a combination of tabs and spaces to make up the
  " desired spacing. If softtabstop equals tabstop and expandtab is not set,
  " vim will always use tabs. When expandtab is set, vim will always use the
  " appropriate number of spaces.

  if l:uses_tabs > 0
    call Indentify(&tabstop . "t")
"    execute "set tabstop=" . g:indentify_tabstop
"    execute "set softtabstop=" . g:indentify_tabstop
"    execute "set shiftwidth=" . g:indentify_tabstop
"    set noexpandtab

  else
    if l:tabstop > 0 && l:tabstop != &tabstop
      call Indentify(l:tabstop)
"      execute "set tabstop=" . l:file_indent
"      execute "set softtabstop=" . &tabstop
"      execute "set shiftwidth=" . &tabstop
"      set expandtab

    endif

  endif
endfunction


""
" Actually set tabstop for the buffer
"
" Sometimes Indentify gets it wrong so you can call this manually.
"
" Set to 4 spaces:
"
"   :call Indentify(4)
"
" Set buffer indentation to tabs with 8 character width:
"
"   :call Indentify("8t")
""
function! Indentify(tabstop)
  if a:tabstop =~ '[tT]$'
    let l:tabstop = substitute(a:tabstop, '[tT]$', '', '')
    execute "set tabstop=" . l:tabstop
    execute "set softtabstop=" . l:tabstop
    execute "set shiftwidth=" . l:tabstop
    set noexpandtab

  else
    execute "set tabstop=" . a:tabstop
    execute "set softtabstop=" . &tabstop
    execute "set shiftwidth=" . &tabstop
    set expandtab
  endif
endfunction


augroup indentify
  autocmd!

  " Run after all other ftplugins (the nested keyword)
  autocmd FileType * nested call s:OverrideIndentation()
augroup END

