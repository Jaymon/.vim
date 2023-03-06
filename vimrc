" http://portablegvim.sourceforge.net/configuration.html
" http://stackoverflow.com/questions/3111351/gvim-portable-plugins
" https://github.com/spf13/spf13-vim
"
"
" stuff I always forget: g:, l:, s: variables definitions :help internal-variables

"runtime bundle/pathogen/autoload/pathogen.vim
"call pathogen#infect()
"call pathogen#helptags()
"call helptags ALL
call env#setup()

set nocompatible

" http://stackoverflow.com/questions/7178964/how-to-turn-off-auto-insert-when-selecting-text-with-gvim?rq=1
behave xterm

" When I upgraded to macos montery (March 2022) I all of a sudden had a a sound when
" doing certain things (it was the Funky system sound), I figured out how to reproduce
" it (hit j when on the last line of a file) and this was what turned it off. Not
" sure why this was now a problem
" https://stackoverflow.com/questions/18589352/how-to-disable-vim-bells-sounds
" https://stackoverflow.com/questions/16047146/disable-bell-in-macvim
set belloff=all

" tells Vim to look in the directory containing the current file (.), then the current
" directory (empty text between two commas), then each directory under the current directory ('**')
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

" this is from vimrc_example.vim
" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

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
set shiftround " When shifting lines, round indentation to the nearest multiple of “shiftwidth.”
set backspace=indent,eol,start
" configure filetype specific stuff in ftplugin/filetype.vim

" Enable indent folding
" http://vimdoc.sourceforge.net/htmldoc/options.html#%27foldclose%27
set foldenable " toggle with zi
set foldmethod=indent
set foldnestmax=2
set foldlevelstart=2
" <CR> in a comment will trigger a new line, and comments will fold to a new
" line at textwidth for all syntax types
" :help fo-table for the values of c, r, and l
" Set 'formatoptions' to break comment lines but not other lines,
" and insert the comment leader when hitting <CR>
set fo-=t fo+=crl


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

" Added 8-26-2022, I'm sick of dealing with wonky syntax, I think my computer is
" fast enough that syntax highlighting should never be a problem
" https://vim.fandom.com/wiki/Fix_syntax_highlighting
" https://stackoverflow.com/a/43419018/5006
"syn sync minlines=2000
autocmd BufEnter * :syntax sync fromstart
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
" sadly, backupdir doesn't respect the //, but this hack using the 'backupext' will make unique backup files
" The path is appended on the end of the file: '/home/docwhat/.vimrc' becomes '.vimrc%home%docwhat~'
" http://stackoverflow.com/a/9528517
au BufWritePre * let &backupext ='@'.substitute(substitute(substitute(expand('%:p:h'), '/', '%', 'g'), '\', '%', 'g'),  ':', '', 'g').'~'
" this is for the .swp files
" http://vim.wikia.com/wiki/Remove_swap_and_backup_files_from_your_working_directory
set directory-=.
set directory^=$VIMTEMP//
" http://stackoverflow.com/questions/4331776/change-vim-swap-backup-undo-file-name
set undodir-=.
set undodir^=$VIMTEMP//
" vim will save view state so the same view gets reloaded on file reopen
" http://vim.wikia.com/wiki/Make_views_automatic
set viewoptions-=options " preserving option state was annoying me, cursor and folding good, options bad
set viewdir=$VIMTEMP//

au BufWinLeave * silent! mkview "make vim save view (state) (folds, cursor, etc)
au BufWinEnter * silent! loadview "make vim load view (state) (folds, cursor, etc)

" http://stackoverflow.com/questions/594838/is-it-possible-to-get-gvim-to-remember-window-size
set sessionoptions+=resize

" Automatically re-read files if unmodified inside Vim.
set autoread

" Delete comment characters when joining lines
set formatoptions+=j

" Allow us to save a file as root, if we have sudo privileges,
" when we're not currently using vim as root
" http://vimingwithbuttar.googlecode.com/hg/.vimrc
cmap w!! %!sudo tee > /dev/null %

" reload the vimrc file in this window
" https://stackoverflow.com/questions/2400264/
" https://stackoverflow.com/a/5794800/5006
" NOTE: this does reload this file, but you have other issues when editing
" other files like `g:loaded_PLUGIN` variables that will keep those files from
" getting reloaded also
"command! Vimreload so echom resolve(expand($MYVIMRC))
if !exists(":Vimreload")
  function ReloadVimrc()
    let l:path = resolve(expand($MYVIMRC))
    if filereadable(l:path)
      silent exe 'so ' . l:path
    endif
  endfunction
  command! Vimreload exec ReloadVimrc()
endif


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
" search: vim replace highlighted text with copied text and put pasted text back into main register
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


"##############################################################################
" configure tab buffers
"##############################################################################
" http://stackoverflow.com/questions/2468939/
" http://stackoverflow.com/questions/11595301/controlling-tab-names-in-vim
" `:help statusline` for a description of the modifiers
au bufEnter * set guitablabel=\[%N\]\ %t\ %M\[%N\]
" I also thought about using <C-<> :tabprev and <c->> :tabnext
"nnoremap <A-.> :tabn<CR>
"nnoremap <A-,> :tabp<CR>
" http://vim.wikia.com/wiki/Alternative_tab_navigation
" http://vim.wikia.com/wiki/Using_tab_pages

" go back to the previous tab, sadly, tabp just goes to tab to the
" left, and :tabl goes to the very last tab, so :tabt will have to do
" http://stackoverflow.com/questions/2119754/switch-to-last-active-tab-in-vim
nmap <leader>t :exe "tabn ".g:lasttab<CR>
nmap <leader>1 1gt<CR>
nmap <leader>2 2gt<CR>
nmap <leader>3 3gt<CR>
nmap <leader>4 4gt<CR>
nmap <leader>5 5gt<CR>
nmap <leader>6 6gt<CR>
nmap <leader>7 7gt<CR>
nmap <leader>8 8gt<CR>
nmap <leader>9 9gt<CR>

" everytime we leave a tab update the lasttab value so the leader t command above works
let g:lasttab = 1
au TabLeave * let g:lasttab = tabpagenr()

" put the opened tab at the end of the list, I prefer that to opening next to
" the tab in which it was opened
" this puts the tab always on the far right, not next to the last tab
" move tabs to the end for new, single buffers (exclude splits)
" http://stackoverflow.com/questions/3998752/nerdtree-open-in-a-new-tab-as-last-tab-in-gvim
autocmd BufNew * if winnr('$') == 1 | tabmove | endif

"##############################################################################


" automatically open a file in readonly mode when swap exists
" http://apple.stackexchange.com/questions/53732/
autocmd SwapExists * :let v:swapchoice='o'


"##############################################################################
" configure NERDTree
" https://github.com/scrooloose/nerdtree
"##############################################################################
"autocmd bufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"nnoremap RN :NERDTreeTabsToggle<CR>
nnoremap RN :NERDTreeMirrorToggle<CR>
let NERDTreeIgnore = ['\.pyc$[[file]]', '__pycache__$[[dir]]']
let NERDTreeQuitOnOpen = 1
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_open_on_new_tab = 0
"#let g:nerdtree_tabs_autoclose = 1
" default is 31...
let NERDTreeWinSize = 40

" https://stackoverflow.com/a/5057406/5006
" you can toggle this behavior with shift+i
let NERDTreeShowHidden=1

"##############################################################################


"##############################################################################
" configure Tagbar
" http://majutsushi.github.com/tagbar/
"##############################################################################
nnoremap RR :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_sort = 1
let g:tagbar_expand = 0
let g:tagbar_foldlevel = 0
let g:tagbar_autoshowtag = 1
"##############################################################################

"##############################################################################
" configure ctrlp
" http://kien.github.io/ctrlp.vim/
"##############################################################################
let g:ctrlp_map = '<leader>r'
" https://github.com/kien/ctrlp.vim/issues/119
" https://github.com/kien/ctrlp.vim/issues/160
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
"##############################################################################


" map omnicompletion to PSPad's ctrl-space
" http://stackoverflow.com/questions/7722177/how-do-i-map-ctrl-x-ctrl-o-to-ctrl-space-in-terminal-vim
" http://vim.wikia.com/wiki/Omni_completion
imap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>

" display what's changed since last save (uses diff command, so not cross-platform)
" http://vim.wikia.com/wiki/Diff_current_buffer_and_the_original_file
" http://stackoverflow.com/questions/749297/can-i-see-changes-before-i-save-my-file-in-vim
map <leader>diff1 :w !diff % -
" this one is way more involved, it splits the screen and puts the original in the left buffer
" from vimrc_example 
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif
map <leader>diff2 :DiffOrig


" make it easier to change current working directory pwd to current file's dir
" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
" CDC = Change to Directory of Current file
command! CDC lcd %:p:h
" to get NerdTree to change to the directory also, open the NT buffer and type
" CD


"##############################################################################
" configure pydiction
" https://github.com/rkulla/pydiction
"##############################################################################
let g:pydiction_location = $VIMHOME . '/bundle/pydiction/complete-dict'


"##############################################################################
" configure snip-mate
" https://github.com/garbas/vim-snipmate
"##############################################################################
" Remap snipmate's trigger key from tab to <C-J>
" cntl-tab was hard to do with my hands
"imap <C-Tab> <Plug>snipMateNextOrTrigger
"smap <C-Tab> <Plug>snipMateNextOrTrigger
imap <C-J> <Plug>snipMateNextOrTrigger
smap <C-J> <Plug>snipMateNextOrTrigger

" This function will load the context.snippet file located in VIMHOME/snippets
function! LoadSnippetsInBuffer()
  let l:path = $VIMHOME . '/snippets/' . &filetype . '.snippets'
  if filereadable(l:path)
    silent exe 'sp ' . l:path
  endif
endfunction
command! Snippets exec LoadSnippetsInBuffer()


"##############################################################################
" session management
" https://bocoup.com/blog/sessions-the-vim-feature-you-probably-arent-using
"##############################################################################
" there also is a plugin but it has dependencies I didn't want to deal with:
" http://peterodding.com/code/vim/session/
" https://github.com/xolox/vim-session/blob/master/INSTALL.md
command! SS mks $VIMTEMP/session.vim
command! RS source $VIMTEMP/session.vim

