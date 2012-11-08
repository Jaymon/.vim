# My gVIM Environment Settings Files

This is how I roll with gVim. Here for my convenience so I can easily keep my vim
environment consistent across multiple machines.

## Plugins

### Pathogen

https://github.com/tpope/vim-pathogen

### Rainbow Parenthesis

http://www.vim.org/scripts/script.php?script_id=3772

### Taglist

http://www.vim.org/scripts/script.php?script_id=273

### Tagbar

This has largely replaced Taglist because I like the hierarchical code tree better

http://majutsushi.github.com/tagbar/

### NerdTree

https://github.com/scrooloose/nerdtree

### Surround

https://github.com/tpope/vim-surround

### syntax/python.vim

https://github.com/hdima/vim-scripts
http://www.vim.org/scripts/script.php?script_id=790

### syntax/php.vim

https://github.com/StanAngeloff/php.vim
https://github.com/EvanDotPro/vim-php-syntax-check
http://www.vim.org/scripts/script.php?script_id=2874

the ctags support isn't really good for php 5.3+, these links will provide some
help for when I finally get around to fixing that:

http://mwop.net/blog/134-exuberant-ctags-with-PHP-in-Vim.html
http://vim-taglist.sourceforge.net/extend.html

### Markdown

I went with this markdown syntax plugin:

https://github.com/tpope/vim-markdown

I had originally installed:

http://www.vim.org/scripts/script.php?script_id=1242

but it would italicize the rest of the body if the word had an underscore in it (eg, sn_id caused 
everything after the underscore until the end to be italicized) while the one I went with
just marks it as an error, which is still not ideal, but better.

## Install

### In Windows 

1. Create %HOMEPATH%\vimfiles

2. cd into %HOMEPATH%\vimfiles

3. clone the repo

    git clone [repo] .

4. make a symlink for the _vimrc file

    mklink %HOMEPATH%\\_vimrc %HOMEPATH%\\vimfiles\\_vimrc

5. make a symlink for the _gvimrc file

    mklink %HOMEPATH%\\_gvimrc %HOMEPATH%\\vimfiles\\_gvimrc

## Warnings

This currently does not work on the console version of Vim, this is *GUI* only

## Plugins I've thought about using

https://github.com/klen/python-mode

https://github.com/jistr/vim-nerdtree-tabs
via: http://stackoverflow.com/questions/2283417/vim-and-nerd-tree-can-nerd-tree-persist-across-tabs-in-macvim
