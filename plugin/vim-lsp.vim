"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" configure vim-lsp
"
" https://github.com/prabirshrestha/vim-lsp
"
" LSP servers are installed using vim-lsp-settings
"   https://github.com/mattn/vim-lsp-settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General LSP configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> gr <plug>(lsp-references)
  "nmap <buffer> K <plug>(lsp-hover)

  set foldmethod=expr
    \ foldexpr=lsp#ui#vim#folding#foldexpr()
    \ foldtext=lsp#ui#vim#folding#foldtext()

  ""
  " Either open or close the preview doc window
  "
  " https://github.com/prabirshrestha/vim-lsp/blob/master/autoload/vital/_lsp/VS/Vim/Window/FloatingWindow.vim
  " https://github.com/prabirshrestha/vim-lsp/blob/master/autoload/lsp/internal/document_hover/under_cursor.vim
  ""
  function! ToggleDocs()
    let l:winid = lsp#internal#document_hover#under_cursor#getpreviewwinid()
    if l:winid != 0
      call popup_close(l:winid)
    else
      call lsp#internal#document_hover#under_cursor#do({})
    endif
  endfunction

  " hitting `K` (shift-k) brings up the preview popup, hitting it again will
  " close the popup window
  nnoremap K :call ToggleDocs()<CR>
endfunction


augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server
    " registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


" turn off warnings
let g:lsp_diagnostics_enabled = 0

" vim-lsp-settings installation directory
let g:lsp_settings_servers_dir = $VIMTEMP . '/vim-lsp-settings/servers'

" Disable auto signature help popup
"let g:lsp_signature_help_enable = 0
let g:lsp_signature_help_enabled = 0
"let g:lsp_completion_documentation_enabled = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Global auto-complete configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrl-j triggers autocomplete
inoremap <C-J> <C-X><C-O>
" ctrl-space also triggers autocomplete, on macOS, you have to disable the 
" input sources keyboard shorcuts to get this one to work:
" System Settings > Keyboard > Keyboard Shortcuts > Input Sources > unselect
" "Select the previous input source" otherwise this won't be available to
" use as a keyboard shortcut
inoremap <C-Space> <C-X><C-O>

" I used these to test what ctrl-space was doing
"nnoremap <C-Space> :echom "Ctrl-Space"<CR>
"nnoremap <C-@> :echom "Ctrl-At"<CR>

" use TAB for navigating the autocomplete menu and ENTER to accept

" select the first value if `tab` is clicked if nothing is currently selected
" https://www.tobymackenzie.com/blog/2022/10/14/vim-autocomplete-setup/
"inoremap <expr> <Tab> pumvisible() ? (complete_info()['selected'] == -1 ? "\<C-n>" : "\<C-y>") : "\<Tab>"
"inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" TAB selects first value if it is the only value and nothing has been
" selected, otherwise it just tabs through values top to bottom.
inoremap <expr> <Tab> pumvisible()
      \ ? (complete_info().selected != -1
      \     ? "\<C-n>"
      \     : (len(complete_info().items) == 1
      \         ? "\<C-y>"
      \         : "\<C-n>"))
      \ : "\<Tab>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" preview was annoying
"set completeopt=menuone,noinsert,noselect,preview
set completeopt=menuone,noinsert,noselect
set infercase
set shortmess+=c

"call <SID>close_floating_window()



"function! ToggleDocs()
"  " If it's a Vim file, just open help (no toggle)
"  if &filetype ==# 'vim'
"    execute 'help ' . expand('<cword>')
"    return
"  endif
"
"  let l:winid = lsp#internal#document_hover#under_cursor#getpreviewwinid()
"  "echo "winid: " . l:winid
"  "echo "bufwinner: " . bufwinnr(l:winid)
"  "echo "winnr: " . win_id2win(l:winid)
"
"  "let l:winid = win_getid()
"  if l:winid != 0 && win_id2win(l:winid) != -1
"    "let l:save_pos = getpos('.')
"    "echo "winid: " . win_id2win(l:winid)
"    call popup_close(l:winid)
"
"    "execute win_id2win(l:winid) . 'wincmd c'
"  else
"    call lsp#internal#document_hover#under_cursor#do({})
"  endif
"
""  let l:doc_win = <SID>get_doc_win()
""  if l:doc_win.is_visible()
""    call <SID>close_floating_window()
""  else
""    call lsp#internal#document_hover#under_cursor#do({})
""  endif
"
"  " Check if LSP hover is available
""  call lsp#internal#document_hover#under_cursor#do({})
""  if exists('*lsp#ui#vim#hover')
""    call lsp#ui#vim#hover()
""
"""    let l:doc_win = <SID>get_doc_win()
"""    if l:doc_win.is_visible()
"""      call <SID>close_floating_window()
"""    else
"""      "call <plug>(lsp-hover)
"""      call lsp#ui#vim#hover()
"""    endif
""  endif
"endfunction
"
"" Map normal mode K to toggle docs
"nnoremap K :call ToggleDocs()<CR>





"function! ShowDocs()
"  " Use Vim help for Vimscript files
"  if &filetype ==# 'vim'
"    execute 'help ' . expand('<cword>')
"    return
"  endif
"
"  " Check if LSP is attached
"  if exists('*lsp#ui#vim#hover')
"    " Show hover in preview window
"    call lsp#ui#vim#hover()
"    return
"  endif
"endfunction
"
"" Keep track of preview window ID
"let s:hover_winid = 0
"
"function! ToggleDocs()
"  " If it's a Vim file, just open help (no toggle)
"  if &filetype ==# 'vim'
"    execute 'help ' . expand('<cword>')
"    return
"  endif
"
"  " Check if LSP hover is available
"  if exists('*lsp#ui#vim#hover')
"    " If hover window already open, close it
"    if g:hover_winid != 0 && bufwinnr(g:hover_winid) != -1
"      " Close the preview window
"      execute bufwinnr(g:hover_winid) . 'wincmd c'
"      let g:hover_winid = 0
"      return
"    endif
"  endif
"
"  " Open hover
"  call lsp#ui#vim#hover()
"  " Store the preview window ID
"  let g:hover_winid = win_getid()
"endfunction
"
"" Map normal mode K to toggle docs
"nnoremap K :call ToggleDocs()<CR>
"
"
"
"nnoremap K :call ShowDocs()<CR>

" make sure dictionary and spell is turned off
"set complete-=k
"set complete-=s
"set complete=.,w,b,u
" let LSP server do the heavy lifting
"set complete=.

"set autocomplete

