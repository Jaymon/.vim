" http://portablegvim.sourceforge.net/configuration.html
" http://stackoverflow.com/questions/3111351/gvim-portable-plugins
" https://github.com/spf13/spf13-vim
"
"
" stuff I always forget: g:, l:, s: variables definitions can be found by
" running `:help internal-variables`

call env#setup()

set nocompatible

" http://stackoverflow.com/questions/7178964/how-to-turn-off-auto-insert-when-selecting-text-with-gvim?rq=1
behave xterm


augroup vimrc
  " reset all autocmds for this file in case it is reloaded
  autocmd!
augroup END


" When I upgraded to macos montery (March 2022) I all of a sudden had a a
" sound when doing certain things (it was the Funky system sound), I figured
" out how to reproduce it (hit j when on the last line of a file) and this was
" what turned it off. Not sure why this was now a problem
" https://stackoverflow.com/questions/18589352/how-to-disable-vim-bells-sounds
" https://stackoverflow.com/questions/16047146/disable-bell-in-macvim
set belloff=all

" tells Vim to look in the directory containing the current file (.), then the
" current directory (empty text between two commas), then each directory under
" the current directory ('**')
set path=.,,**

set showmode
:set virtualedit=onemore

" http://vim.wikia.com/wiki/Working_with_Unicode
" http://vim.1045645.n5.nabble.com/what-s-a-quot-conversion-error-quot-and-how-do-I-correct-it-td4416508.html
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,latin1
endif

augroup vimrc
  " this is from vimrc_example.vim
  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup END


" mess with the status bar
set ruler " show the cursor position all the time
set showcmd " display incomplete commands

" line numbering
" nu or rnu turn linenumbering (nu - traditional numbering, rnu - relative
" numbering) on
" http://jeffkreeftmeijer.com/2013/vims-new-hybrid-line-number-mode/
set number
" I've been having really slow scrolling, turns out turning off relativenumber
" restores holding down j or k speed to really fast, not sure why but I'm
" disabling this for right now, see the SO answer for more insight:
" https://stackoverflow.com/a/34159294/5006
"set relativenumber
" for normal numbering, something like 5 is appropriate to easily handle files
" up to 99999 lines long, but for relative numbering, I think 2-3 is
" sufficient
set numberwidth=5 " Set line numbering to take up N spaces
set cursorline
set scrolloff=3 " N lines above/below cursor when scrolling

" searching
set incsearch
set hlsearch
set ignorecase
set smartcase


"##############################################################################
" Indentation stuff
"##############################################################################
" http://www.jonlee.ca/hacking-vim-the-ultimate-vimrc/
" http://www.cs.swarthmore.edu/help/vim/indenting.html
set autoindent
set tabstop=2 " set tab character to N characters
"set softtabstop=4 " let backspace delete indent
execute "set softtabstop=" . &tabstop
set expandtab " turn tabs into spaces
"set shiftwidth=4 " indent width for autoindent
execute "set shiftwidth=" . &tabstop
" When shifting lines, round indentation to the nearest multiple of
" “shiftwidth.”
set shiftround
set backspace=indent,eol,start
" configure filetype specific stuff in ftplugin/filetype.vim

" Enable indent folding
" http://vimdoc.sourceforge.net/htmldoc/options.html#%27foldclose%27
"set foldenable " toggle with zi
set foldmethod=indent
set foldnestmax=2
" start each new file with all fold levels expanded, this is affected by mkview
" and loadview
set foldlevelstart=99
" https://stackoverflow.com/a/360634
" space will collapse/expand the current fold in normal mode
nnoremap <space> za
"vnoremap <space> zf

" <CR> in a comment will trigger a new line, and comments will fold to a new
" line at textwidth for all syntax types
" :help fo-table for the values of c, r, and l
" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR>
set fo-=t fo+=crl

" don't automatically insert a comment leader if hitting o in a comment
set fo-=o

augroup vimrc
  " But this option seems to be set by specific filetypes, so let's be more
  " aggressive with removing it because it drives me nuts
  " https://superuser.com/a/271024
  autocmd BufEnter * setlocal fo-=o
augroup END

" Delete comment characters when joining lines
set formatoptions+=j

" recognize numbered lists (NOTE this doesn't play nice with `2` see :h fo-n
" and :h fo-2)
set formatoptions+=n

" allow dashes to be used as a list also
let &formatlistpat .= '\|^\s*-\s*'

augroup vimrc
  " on opening a new file we will only set the textwidth if it hasn't been set
  " by something else
  autocmd BufRead * if &textwidth == 0 | set textwidth=79 | endif
augroup END


"##############################################################################
" Syntax and Highlighting
"##############################################################################

" turn on syntax highlighting
filetype plugin indent on " indent depends on filetype
syntax on
colorscheme jaymon_light

" re-parse the file to fix syntax errors
nmap <leader>rs :syn sync fromstart<CR>
nmap <leader>parse :syn sync fromstart<CR>

augroup vimrc
  " Added 8-26-2022, I'm sick of dealing with wonky syntax, I think my computer
  " is fast enough that syntax highlighting should never be a problem
  " https://vim.fandom.com/wiki/Fix_syntax_highlighting
  " https://stackoverflow.com/a/43419018/5006
  "syn sync minlines=2000
  autocmd BufEnter * :syntax sync fromstart
augroup END

" disabled 1-3-2023, these caused noticeable lag
"autocmd Insertleave * :syntax sync minlines=200 maxlines=200
"autocmd CursorMoved * :syntax sync minlines=100 maxlines=100
" ...To ensure syntax highlighting always works on large files, simply increase
" the redraw time in your .vimrc file
set redrawtime=10000


"##############################################################################
" Backup and saving stuff
"##############################################################################
set history=1000
set backupcopy=yes
set backup
set writebackup
set undofile
set undolevels=1000
set undoreload=10000
" save ~ files somewhere where I don't have to bother with them
" http://stackoverflow.com/questions/2823608/
set backupdir-=.
set backupdir^=$VIMTEMP//

augroup vimrc
  " sadly, backupdir doesn't respect the //, but this hack using the
  " 'backupext' will make unique backup files The path is appended on the end
  " of the file: '/home/docwhat/.vimrc' becomes '.vimrc%home%docwhat~'
  " http://stackoverflow.com/a/9528517
  au BufWritePre *
        \ let &backupext ='@'.substitute(
        \   substitute(
        \     substitute(
        \       expand('%:p:h'),
        \       '/', '%', 'g'
        \     ),
        \     '\', '%', 'g'
        \   ),
        \   ':', '', 'g'
        \ ).'~'
augroup END
  
" this is for the .swp files
" http://vim.wikia.com/wiki/Remove_swap_and_backup_files_from_your_working_directory
set directory-=.
set directory^=$VIMTEMP//
" http://stackoverflow.com/questions/4331776/change-vim-swap-backup-undo-file-name
set undodir-=.
set undodir^=$VIMTEMP//
" vim will save view state so the same view gets reloaded on file reopen
" http://vim.wikia.com/wiki/Make_views_automatic
" preserving option state was annoying me, cursor and folding good, options bad
set viewoptions-=options
set viewdir=$VIMTEMP//

augroup vimrc
  " NOTE -- these might need to be commented out when writing/testing vimscript
  " make vim save view (state) (folds, cursor, etc)
  au BufWinLeave * silent! mkview
  " make vim load view (state) (folds, cursor, etc)
  au BufWinEnter * silent! loadview
augroup END

" http://stackoverflow.com/questions/594838/is-it-possible-to-get-gvim-to-remember-window-size
set sessionoptions+=resize

" Automatically re-read files if unmodified inside Vim.
set autoread


"##############################################################################
" Handle copy/paste better
"##############################################################################

" make Y behave like D and C
nmap Y y$

" make it easy to select recently pasted stuff (similar to gv for recently selected)
" http://stackoverflow.com/questions/4312664/is-there-a-vim-command-to-select-pasted-text
" http://stackoverflow.com/questions/4775088/vim-how-to-select-pasted-block
nmap gp `[v`]

" reformat paste (paste and reformat/reindent)
" http://www.slideshare.net/zendcon/vim-for-php-programmers-presentation (slide 27)
" !!! 7-17-2022 - Using the standard CLI vim this was causing whatever was in the
" buffer to be pasted into the top of the opened file, it didn't seem to play
" nice with `set clipboard+=unnamed`, this was for actual vim, not macvim
" which seemed to work just fine, I tracked it down to this command and so I'm
" disabling it to see if I even notice what it does (it was the lowercase p
" line specifically)
"nnoremap <esc>p p'[v' ]=
"nnoremap <esc>P P'[v' ]=

" map ctrl-p to paste after the current line and match indent
" this makes P paste after cursor, p paste before current line, and ctrl-p
" paste after current line, all should match current indent
map <C-p> :pu<CR>`[v`]==<CR>

" http://superuser.com/questions/321547/how-do-i-replace-paste-yanked-text-in-vim-without-yanking-the-deleted-lines
" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

" when pasting over selected text don't replace the pasted text with the
" replaced text, this was what <leader>p was basically doing (I think) but
" I've never internalized that command and this is one of the things that bugs
" me the most
" https://unix.stackexchange.com/a/390905/118750
" search: vim replace highlighted text with copied text and put pasted text back
" into main register
vnoremap p p:let @*=@0<CR>

" this maps the "* register to the unnamed register so you can copy/paste between instances
" http://superuser.com/a/296308
set clipboard+=unnamed

"##############################################################################

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

" for switching buffers, no more Ctrl-w j, now you can just do ctrl-j
"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l

"nnoremap <C-j> <C-w>10>
"nnoremap <C-,> <C-w>10<
"nnoremap <C-+> <C-w>+
"nnoremap <C--> <C-w>-
" http://vim.wikia.com/wiki/Fast_window_resizing_with_plus/minus_keys
nnoremap <S-Up> <C-w>10-
nnoremap <S-Down> <C-w>10+
nnoremap <S-Right> <C-w>10>
nnoremap <S-Left> <C-w>10<


" maps jumping 10 lines/characters ahead to ALT (OPTION) + movement key, so
" <A-j> would jump 10 lines down. Sadly, <A-j> and <M-j> didn't work for me,
" but I was able to run `sed -n l` and type ALT+j and get the value it
" emitted, as described here: 
"   * https://vi.stackexchange.com/a/18080
"   * https://stackoverflow.com/a/49053064
nnoremap ∆ 10j
nnoremap ˚ 10k
nnoremap ˙ 10h
nnoremap ¬ 10l


"##############################################################################
" configure tab buffers
"##############################################################################
augroup vimrc
  " http://stackoverflow.com/questions/2468939/
  " http://stackoverflow.com/questions/11595301/controlling-tab-names-in-vim
  " `:help statusline` for a description of the modifiers
  autocmd bufEnter * set guitablabel=\[%N\]\ %t\ %M\[%N\]
augroup END

" go back to the previous tab, sadly, tabp just goes to tab to the
" left, and :tabl goes to the very last tab, so :tabt will have to do
" http://stackoverflow.com/questions/2119754/switch-to-last-active-tab-in-vim
nmap <leader>t :exe "tabn ".g:lasttab<CR>

" everytime we leave a tab update the lasttab value so the leader t command
" above works
let g:lasttab = 1

augroup vimrc
  autocmd TabLeave * let g:lasttab = tabpagenr()

  " put the opened tab at the end of the list, I prefer that to opening next to
  " the tab in which it was opened
  " this puts the tab always on the far right, not next to the last tab
  " move tabs to the end for new, single buffers (exclude splits)
  " http://stackoverflow.com/questions/3998752/nerdtree-open-in-a-new-tab-as-last-tab-in-gvim
  autocmd BufNew * if winnr('$') == 1 | tabmove | endif
augroup END

" Number keys map to the same tab, over the years, this has become the primary
" way I jump between tabs
nmap <leader>1 1gt<CR>
nmap <leader>2 2gt<CR>
nmap <leader>3 3gt<CR>
nmap <leader>4 4gt<CR>
nmap <leader>5 5gt<CR>
nmap <leader>6 6gt<CR>
nmap <leader>7 7gt<CR>
nmap <leader>8 8gt<CR>
nmap <leader>9 9gt<CR>

"##############################################################################


augroup vimrc
  " automatically open a file in readonly mode when swap exists
  " http://apple.stackexchange.com/questions/53732/
  autocmd SwapExists * :let v:swapchoice='o'
augroup END


" make it easier to change current working directory pwd to current file's dir
" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
" CDC = Change to Directory of Current file
"command! CDC lcd %:p:h
" to get NerdTree to change to the directory also, open the NT buffer and type
" CD

