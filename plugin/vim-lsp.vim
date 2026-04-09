"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" configure vim-lsp
"
" Start the LSP server:
"
"   :call lsp#enable()
"
" Turn off the LSP server:
"
"   :call lsp#disable()
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

"  set foldmethod=expr
"    \ foldexpr=lsp#ui#vim#folding#foldexpr()
"    \ foldtext=lsp#ui#vim#folding#foldtext()

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

  " Use current working directory as root for all LSP servers
"  if exists('*lsp#register_server')
"    function! UseCWDAsRoot(server_info) abort
"      " Override the root_uri to cwd
"      let l:cwd = getcwd()
"      " lsp#register_server expects root_uri as a URI, not path
"      let a:server_info['root_uri'] = 'file://' . l:cwd
"      return a:server_info
"    endfunction
"
"    " This hook runs before any server is started
"    let g:lsp#register_server_hook = function('UseCWDAsRoot')
"  endif

endfunction


augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server
    " registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


" Don't auto-start the LSP
" Start the server: `:call lsp#enable()`
" Stop the server: `:call lsp#disable()`
let g:lsp_auto_enable = 0

" turn off warnings
let g:lsp_diagnostics_enabled = 0

" vim-lsp-settings installation directory
let g:lsp_settings_servers_dir = $VIMTEMP . '/vim-lsp-settings/servers'

" Disable auto signature/preview help popup
let g:lsp_signature_help_enabled = 0

" Disable auto-highlighting of variable under the cursor, this doesn't seem to
" be overly reliable and it leaves highlights up after the cursor is moved.
" I'd actually like to switch * to do this, so it only highlights in the
" current scope
let g:lsp_document_highlight_enabled = 0

" turn off folding, which can be expensive
let g:lsp_fold_enabled = 0

" turn off all diagnostics, which can be expensive
let g:lsp_diagnostics_enabled = 0

" sshould be off by default, but just in case
let g:lsp_semantic_enabled = 0


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


" make sure dictionary and spell is turned off
"set complete-=k
"set complete-=s
"set complete=.,w,b,u
" let LSP server do the heavy lifting
"set complete=.

"set autocomplete

