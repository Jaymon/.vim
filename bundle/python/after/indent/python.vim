if !g:pymode || !g:pymode_indent
    finish
endif

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4

" these are set in my vimrc and should be considered preference
"setlocal shiftround
"setlocal expandtab

" these are set in the built-in python indentation, I disabled these on
" 1-5-2023, if I want to re-activate my custom indentation then I should
" uncomment these 4 lines. I want to use the built-in indentation and see how
" I like it for a bit before I delete these and delete all the files
"setlocal nolisp
"setlocal autoindent
"setlocal indentexpr=pymode#indent#get_indent(v:lnum)
"setlocal indentkeys=!^F,o,O,<:>,0),0],0},=elif,=except

" Ignore files matching these patterns when opening files based on a glob pattern.
set wildignore+=.pyc

