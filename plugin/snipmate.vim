"##############################################################################
" configure snip-mate
" https://github.com/garbas/vim-snipmate
"
" This should load before pack/third-party/start/snipmate, you can verify this
" by running `:scriptnames` and verifying the order
"##############################################################################

" Remap snipmate's trigger key from tab to <C-J> (CNTRL-J)
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

