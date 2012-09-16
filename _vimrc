" http://portablegvim.sourceforge.net/configuration.html
" http://stackoverflow.com/questions/3111351/gvim-portable-plugins

set nocompatible

call pathogen#infect()

" https://github.com/maxbrunsfeld/vim-yankstack
" call yankstack#setup()

source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function! MyDiff()
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

set showmode
:set virtualedit=onemore

" line numbering
set nu
set relativenumber
set numberwidth=5 " Set line numbering to take up 5 spaces
set cursorline
set scrolloff=3 " N lines above/below cursor when scrolling

" Turn on smart indent
" http://www.jonlee.ca/hacking-vim-the-ultimate-vimrc/
" http://www.cs.swarthmore.edu/help/vim/indenting.html
set autoindent
set smartindent
set cindent
set tabstop=2 " set tab character to N characters
set softtabstop=2 " let backspace delete indent
set expandtab " turn tabs into whitespace
set shiftwidth=2 " indent width for autoindent
filetype indent on " indent depends on filetype

" searching (some of these are enabled in vimrc_example.vim)
set incsearch
set hlsearch
set ignorecase
set smartcase

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

if has("win32")
  " http://stackoverflow.com/questions/7175277/using-taglist-plugin-in-gvim-on-windows
  let Tlist_Ctags_Cmd= '"' . $HOME . '/vimfiles/bundle/taglist/ctags.exe"'
  " doesn't work very well, use :so instead I guess
  " http://vim.wikia.com/wiki/Change_vimrc_with_auto_reload
  " autocmd! bufwritepost _vimrc source %

else
  " When vimrc is edited, automatically reload it!
  " http://vimingwithbuttar.googlecode.com/hg/.vimrc
  " autocmd! bufwritepost .vimrc source %

endif

" backup stuff
set history=1000
set backup
set undofile
set undolevels=1000
set undoreload=10000
" save ~ files somewhere where I don't have to bother with them
" http://stackoverflow.com/questions/2823608/
set backupdir-=.
set backupdir^=$TEMP//
" this is for the .swp files
" http://vim.wikia.com/wiki/Remove_swap_and_backup_files_from_your_working_directory
set directory-=.
set directory^=$TEMP//
" http://stackoverflow.com/questions/4331776/change-vim-swap-backup-undo-file-name
set undodir-=.
set undodir^=$TEMP//
au BufWinLeave * silent! mkview "make vim save view (state) (folds, cursor, etc)
au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)

" http://www.vim.org/scripts/script.php?script_id=3772
au VimEnter * cal rainbow_parentheses#toggleall()

" taglist plugin config
" this slowed down : by 1 second while vim
" waited for key timeout, better to just have TT work
"nnoremap :t<CR> :TlistToggle<CR>
nnoremap TT :TlistToggle<CR>
let Tlist_Exit_OnlyWindow = 1     " exit if taglist is last window open
let Tlist_Show_One_File = 1       " Only show tags for current buffer
let Tlist_Enable_Fold_Column = 0  " no fold column (only showing one file)

" do some cool text moving, the only one I would like to add is to append one
" line to the endo of another line
" for example, suppose you have 2 lines:
"   for x in y:
"     print y
"
" I would like to able to do something like <A-H>  on the second line and end up with:
"   for x in y: print y
" 
" http://vim.wikia.com/wiki/Moving_lines_up_or_down
" http://stackoverflow.com/questions/741814/move-entire-line-up-and-down-in-vim
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Allow us to save a file as root, if we have sudo privileges,
" when we're not currently useing vim as root
" http://vimingwithbuttar.googlecode.com/hg/.vimrc
cmap w!! %!sudo tee > /dev/null %

" make Y behave like D and C
nmap Y y$

""" comments.vim
"A more elaborate comment set up. Use Ctr-C to comment and Ctr-x to uncomment
" This will detect file types and use oneline comments accordingle. Cool
" because you visually select regions and comment/uncomment the whole region.
" works with marked regions to.
" to activate, just place it in your plugins dir
" https://github.com/vim-scripts/comments.vim
" http://www.vim.org/scripts/script.php?script_id=1528

" this maps the "* register to the unnamed register so you can copy/paste between instances
" http://superuser.com/a/296308
set clipboard+=unnamed
"nnoremap yy yy"*yy
"vnoremap y ygv"+y


" ###From an idea by Michael Naumann
"You press * or # to search for the current visual selection !! Really useful
" http://vimingwithbuttar.googlecode.com/hg/.vimrc
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
" End From an idea by Michael Nauman

" http://vim.wikia.com/wiki/VimTip1066
" http://vim.wikia.com/wiki/Insert_newline_without_entering_insert_mode
" deletes blank line below
nnoremap <silent><S-BS> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
" deletes blank line above
nnoremap <silent><C-BS> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
" adds a blank line below
nnoremap <silent><S-CR> :set paste<CR>m`o<Esc>``:set nopaste<CR>
" adds a blank line above
nnoremap <silent><C-CR> :set paste<CR>m`O<Esc>``:set nopaste<CR>

