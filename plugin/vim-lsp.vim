"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" configure vim-lsp
"
" https://github.com/prabirshrestha/vim-lsp
"
" LSP servers are installed using vim-lsp-settings
"   https://github.com/mattn/vim-lsp-settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let s:pylsp = $VIMHOME . "/.venv3.12.11/bin/pylsp"
"
"if executable(s:pylsp)
"    " pip install python-lsp-server
"    au User lsp_setup call lsp#register_server({
"        \ 'name': 'pylsp',
"        \ 'cmd': {server_info->[s:pylsp]},
"        \ 'allowlist': ['python'],
"        \ })
"endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> K <plug>(lsp-hover)
endfunction


augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server
    " registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


set foldmethod=expr
  \ foldexpr=lsp#ui#vim#folding#foldexpr()
  \ foldtext=lsp#ui#vim#folding#foldtext()


" turn off warnings
let g:lsp_diagnostics_enabled = 0

" vim-lsp-settings installation directory
let g:lsp_settings_servers_dir = $VIMTEMP . '/vim-lsp-settings/servers'

" ctrl-j triggers autocomplete
inoremap <C-J> <C-X><C-O>
" ctrl-space also triggers autocomplete
inoremap <C-Space> <C-x><C-o>

" use TAB for navigating the autocomplete menu and ENTER to accept
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

set completeopt=menuone,noinsert,noselect,preview
set infercase
set shortmess+=c

set autocomplete

