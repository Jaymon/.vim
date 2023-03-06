"##############################################################################
" configure ctrlp
" http://kien.github.io/ctrlp.vim/
"
" This should load before pack/third-party/opt/ctrlp, you can verify this
" by running `:scriptnames` and verifying the order
"
" ctrlp is currently (March 2023) in opt, which means it doesn't load by
" default, so to use crtlp you will need to source it:
"
"   :packadd ctrlp
"##############################################################################

let g:ctrlp_map = '<leader>r'
" https://github.com/kien/ctrlp.vim/issues/119
" https://github.com/kien/ctrlp.vim/issues/160
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }

