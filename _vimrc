" http://portablegvim.sourceforge.net/configuration.html
" http://stackoverflow.com/questions/3111351/gvim-portable-plugins

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" custom jay settings
set showmode

" line numbering
set nu
set numberwidth=5 " Set line numbering to take up 5 spaces
set cursorline

" Turn on smart indent
" http://www.jonlee.ca/hacking-vim-the-ultimate-vimrc/
" http://www.cs.swarthmore.edu/help/vim/indenting.html
set autoindent
set smartindent
set cindent
set tabstop=2 " set tab character to N characters
set expandtab " turn tabs into whitespace
set shiftwidth=2 " indent width for autoindent
filetype indent on " indent depends on filetype

" http://wiki.python.org/moin/Vim
au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4

" Enable indent folding
" http://vimdoc.sourceforge.net/htmldoc/options.html#%27foldclose%27
set foldenable " toggle with zi
set foldmethod=indent
set foldnestmax=2
set foldlevelstart=2
" http://vim.wikia.com/wiki/All_folds_open_when_open_a_file
"autocmd Syntax py,php setlocal foldmethod=indent
"autocmd Syntax py,php normal zR

colorscheme jaymon
set columns=160 lines=65

if has('gui_running')
  set guifont=Courier_New:h10:cANSI
  au syntax * cal rainbow#activate()
  " this maps the "* register to the unnamed register so you can copy/paste between instances
  " http://superuser.com/a/296308
  :set clipboard+=unnamed 
endif
