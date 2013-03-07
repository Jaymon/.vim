set guifont=Courier_New:h10:cANSI

"set columns=160 lines=65
" we do our best to set cols to half the width and lines to about 2/3 height
" http://vim.1045645.n5.nabble.com/Setting-width-to-half-screen-size-td1172185.html
" TODO: make work in macvim
autocmd GUIEnter * let &columns = 9999 | let &columns = &columns/3 + &columns/4
autocmd GUIEnter * let &lines = 999 | let &lines = &lines/2 + &lines/3

set listchars=tab:˻\ ,eol:˼,trail:˻,extends:˻,precedes:˻
set list
" the 2 lines work to match space, but I don't like it since it messes with
" highlight current line, I guess I just have to hope for space: support in
" listchars, see https://groups.google.com/forum/?fromgroups=#!topic/vim_dev/dIQHjW1g92s
" http://stackoverflow.com/questions/1675688/make-vim-show-all-white-spaces-as-a-character
" set conceallevel=2 concealcursor=nv
" autocmd BufWinEnter * syntax match NonText / / conceal cchar=˻