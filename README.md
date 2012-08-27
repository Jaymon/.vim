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

## Install

### In Windows 

1. Create %HOMEPATH%\vimfiles

2. cd into %HOMEPATH%\vimfiles

3. clone the repo

    git clone [repo] .

4. make a symlink for the _vimrc file

    mklink %HOMEPATH%\_vimrc %HOMEPATH%\vimfiles\_vimrc

## Warnings

This currently does not work on the console version of Vim, this is *GUI* only
