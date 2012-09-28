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

### Syntax/python.vim

https://github.com/hdima/vim-scripts
http://www.vim.org/scripts/script.php?script_id=790

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
