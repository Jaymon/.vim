" http://portablegvim.sourceforge.net/configuration.html
" http://stackoverflow.com/questions/3111351/gvim-portable-plugins
" https://github.com/spf13/spf13-vim
"
"
" stuff I always forget: g:, l:, s: variables definitions :help internal-variables

runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()
call env#setup()

set nocompatible

" http://stackoverflow.com/questions/7178964/how-to-turn-off-auto-insert-when-selecting-text-with-gvim?rq=1
behave xterm

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
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

" line numbering
" nu or rnu turn linenumbering (nu - traditional numbering, rnu - relative
" numbering) on
" http://jeffkreeftmeijer.com/2013/vims-new-hybrid-line-number-mode/
set number
set relativenumber
" for normal numbering, something like 5 is appropriate to easily handle files
" up to 99999 lines long, but for relative numbering, I think 2-3 is
" sufficient
set numberwidth=4 " Set line numbering to take up N spaces
set cursorline
set scrolloff=3 " N lines above/below cursor when scrolling

" turn on go stuff if it is available
" TODO -- move this into its own bundle
if empty($GOROOT) && (!empty($GOPATH) || executable('go'))
  let $GOROOT = fnamemodify(system('which go'), ':p:h:h')
endif
if !empty($GOROOT)
  set rtp+=$GOROOT/misc/vim
endif

" Indent stuff
" http://www.jonlee.ca/hacking-vim-the-ultimate-vimrc/
" http://www.cs.swarthmore.edu/help/vim/indenting.html
set autoindent
" Generally, 'smartindent' or 'cindent' should only be set manually if you're
" not satisfied with how file type based indentation works. 
" looks like smartindent was deprecated for cindent, and should be activated
" in specific filetypes, not generally
" http://vim.wikia.com/wiki/Indenting_source_code
"set smartindent
set tabstop=2 " set tab character to N characters
set softtabstop=2 " let backspace delete indent
set expandtab " turn tabs into whitespace
set shiftwidth=2 " indent width for autoindent
set backspace=indent,eol,start
" configure filetype specific stuff in ftplugin/filetype.vim

" searching
set incsearch
set hlsearch
set ignorecase
set smartcase

" Enable indent folding
" http://vimdoc.sourceforge.net/htmldoc/options.html#%27foldclose%27
set foldenable " toggle with zi
set foldmethod=indent
set foldnestmax=2
set foldlevelstart=2

" turn on syntax highlighting
filetype plugin indent on " indent depends on filetype
syntax on
colorscheme jaymon_light

" backup stuff
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

" Allow us to save a file as root, if we have sudo privileges,
" when we're not currently using vim as root
" http://vimingwithbuttar.googlecode.com/hg/.vimrc
cmap w!! %!sudo tee > /dev/null %

" make Y behave like D and C
nmap Y y$

"##############################################################################
" Handle copy/paste better
"##############################################################################

" make it easy to select recently pasted stuff (similar to gv for recently selected)
" http://stackoverflow.com/questions/4312664/is-there-a-vim-command-to-select-pasted-text
" http://stackoverflow.com/questions/4775088/vim-how-to-select-pasted-block
nmap gp `[v`]

" reformat paste
" http://www.slideshare.net/ZendCon/vim-for-php-programmers-presentation
" (slide 27)
nnoremap <esc>P P'[v' ]=
nnoremap <esc>p p'[v' ]=

" map ctrl-p to paste after the current line and match indent
" this makes p paste after cursor, P paste before current line, and ctrl-p
" paste after current line, all should match current indent
map  <C-p> :pu<CR>`[v`]==<CR>

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


" re-parse the file to fix syntax errors
nmap <leader>rs :syn sync fromstart<CR>
nmap <leader>parse :syn sync fromstart<CR>


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
autocmd BufNew * if winnr('$') == 1 | tabmove99 | endif

"##############################################################################

"cnoreabbrev <expr> tabnew getcmdtype() == ":" && getcmdline() == "tabnew" ? "tab drop" : "tabnew" 

" automatically open a file in readonly mode when swap exists
" http://apple.stackexchange.com/questions/53732/
"autocmd SwapExists * :let v:swapchoice='q'
autocmd SwapExists * call IgnoreSwapDialog()

function! IgnoreSwapDialog()
  "echom expand('%:p') 
  :let v:swapchoice='o'
  " TODO -- 5-18-2016 - I tried and tried to figure out a way to close the tab after
  " using 'q' to quit on the new tab, but I couldn't figure out any way to do
  " it :(
  "echom "buffer number ".bufnr('')
  ":tabclose tabpagenr()
  ":tabclose
  "tabpagenr()
  "silent exe 'bwipeout ' . bufnr('')




"  echom expand('%') 
"  echom tabpagenr('$')
"  for t in range(1, tabpagenr('$'))
"    echo "start tab list"
"    for b in tabpagebuflist(t)
"      echom "bufname ".bufname(b)
"      if !buflisted(b)
"        echom "quitting the buffer"
"        :q
"        "echom getbufvar(b, '&filetype')
""        if getbufvar(b, '&filetype') == "netrw"
""          silent exe 'bwipeout ' . b
""          "silent exe 'Rexplore'
""        endif
"      endif
"    endfor
"    echo "stop tab list"
"  endfor
"  echom "done with buffer iteration"
endfunction




"##############################################################################
" configure NERDTree
" https://github.com/scrooloose/nerdtree
"##############################################################################
"autocmd bufEnter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"nnoremap RN :NERDTreeTabsToggle<CR>
nnoremap RN :NERDTreeMirrorToggle<CR>
let NERDTreeIgnore = ['\.pyc$[[file]]']
let NERDTreeQuitOnOpen = 1
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_open_on_new_tab = 0
"#let g:nerdtree_tabs_autoclose = 1
" default is 31...
let NERDTreeWinSize = 40

"##############################################################################


"##############################################################################
" configure netrw to work more like NERDTree
"##############################################################################
let g:netrw_list_hide = '\.pyc$'
let g:netrw_liststyle = 3
"nnoremap RN :call ToggleNetrw()<CR>
"nnoremap NN :call ToggleNetrw()<CR>
"nnoremap RN :E<CR>
"nnoremap RN :Rexplore<CR>

" these functions eliminate the (R)ename mapping in the netrw buffer so I can
" continue to use the RN and RR mappings that I've grown so accustomed to
" http://vi.stackexchange.com/a/5532
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END
function! NetrwMapping()
    nunmap <buffer> R
endfunction

" This will toggle netrw on/off
function! ToggleNetrw()
  let l:bn = bufnr('%')
  if getbufvar(l:bn, '&filetype') == "netrw"
    "silent exe :q
    :q
  else
    "silent exe :Texplore
    :Texplore
  endif

endfunction

" we do this to try and get rid of ghost netrw buffers
" https://github.com/tpope/vim-vinegar/issues/13#issuecomment-39539835
function! QuitNetrw()
  " http://stackoverflow.com/questions/2974192/how-can-i-pare-down-vims-buffer-list-to-only-include-active-buffers
  " http://stackoverflow.com/a/1534979/5006
  " http://vim.wikia.com/wiki/Deleting_a_buffer_without_closing_the_window
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      if buflisted(b)
        echon getbufvar(b, '&filetype')
        if getbufvar(b, '&filetype') == "netrw"
          silent exe 'bwipeout ' . b
          "silent exe 'Rexplore'
        endif
      endif
    endfor
  endfor
endfunction
autocmd VimLeavePre * call QuitNetrw()

" get rid of .netrwhist file in vim home
let g:netrw_home = $VIMTEMP


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


" helpful for syntax highlighting, show what highlight group is under cursor
" once again, I can never remember what I map this to
map  <leader>sg :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>
map  <leader>hl :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>

" map omnicompletion to PSPad's ctrl-space
" http://stackoverflow.com/questions/7722177/how-do-i-map-ctrl-x-ctrl-o-to-ctrl-space-in-terminal-vim
" http://vim.wikia.com/wiki/Omni_completion
imap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>

" display what's changed since last save (uses diff command, so not cross-platform)
" http://vim.wikia.com/wiki/Diff_current_buffer_and_the_original_file
" http://stackoverflow.com/questions/749297/can-i-see-changes-before-i-save-my-file-in-vim
map <leader>d1 :w !diff % -
" this one is way more involved, it splits the screen and puts the original in the left buffer
" from vimrc_example 
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif
map <leader>d2 :DiffOrig


" make it easier to change current working directory pwd to current file's dir
" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
nnoremap <leader>cd :cd %:p:h<CR>
" CDC = Change to Directory of Current file
command CDC cd %:p:h


"##############################################################################
" configure pydiction
" https://github.com/rkulla/pydiction
"##############################################################################
let g:pydiction_location = $VIMHOME . '/bundle/pydiction/complete-dict'

