" http://portablegvim.sourceforge.net/configuration.html
" http://stackoverflow.com/questions/3111351/gvim-portable-plugins

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
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
call pathogen#infect()
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

" this maps the "* register to the unnamed register so you can copy/paste between instances
" http://superuser.com/a/296308
:set clipboard+=unnamed

if has("win32")
  " http://stackoverflow.com/questions/7175277/using-taglist-plugin-in-gvim-on-windows
  let Tlist_Ctags_Cmd= '"' . $HOME . '/vimfiles/bundle/taglist/ctags.exe"'
  " save ~ files somewhere where I don't have to bother with them
  " http://stackoverflow.com/questions/2823608/
  set backupdir-=.
  set backupdir^=$TEMP//
  " this is for the .swp files
  " http://vim.wikia.com/wiki/Remove_swap_and_backup_files_from_your_working_directory
  set directory-=.
  set directory=$TEMP//
endif

" http://www.vim.org/scripts/script.php?script_id=3772
au VimEnter * cal rainbow_parentheses#toggleall()

" taglist plugin config
nnoremap :t<CR> :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1     " exit if taglist is last window open
let Tlist_Show_One_File = 1       " Only show tags for current buffer
let Tlist_Enable_Fold_Column = 0  " no fold column (only showing one file)
