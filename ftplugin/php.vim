" configure the php doc plugin
" https://github.com/sumpygump/php-documentor-vim

inoremap <buffer> <leader>d :call PhpDoc()<CR>
nnoremap <buffer> <leader>d :call PhpDoc()<CR>
vnoremap <buffer> <leader>d :call PhpDocRange()<CR>
let g:pdv_cfg_Author = ''
let g:pdv_cfg_Package = ''
let g:pdv_cfg_Version = '0.1'
let g:pdv_cfg_ClassTags = ["version","author","since","package"]

