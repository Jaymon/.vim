# My VIM Environment Settings Files

This is here for my convenience so I can easily keep my vim environment consistent across multiple machines.


-------------------------------------------------------------------------------

## Installation

### In Mac or Linux

1. Create `$HOME/.vim`

2. cd into `$HOME/.vim`

3. clone the repo

    ```
    $ git clone --recursive [repo] .
    ```

4. Run the install script

    ```
    $ $HOME/.vim/install.sh
    ```


### Re-initialize Submodules

I moved (March 2023) the submodules from `bundle` to `pack/third-party/start` and this is how I re-initialized the modules:

```
$ git submodule init
$ git submodule update
```

-------------------------------------------------------------------------------

## Plugins

to update all the submodules:

    $ git submodule foreach git pull origin master
    
To update a specific submodule, from repo root directory:

    $ cd pack/third-party/<PATH-TO-SUBMODULE>
    $ git pull origin master
    $ cd -


### [Tagbar](https://github.com/preservim/tagbar)

This replaced Taglist because I like the hierarchical code tree better.

It depends on [ctags](https://github.com/universal-ctags/ctags), which can be installed on mac using brew:

    $ brew install universal-ctags

I set this up with:

    $ git submodule add -b master https://github.com/preservim/tagbar.git pack/third-party/start/tagbar
    
I last updated it on April 14, 2025 to get javascript/typescript working:

    $ cd pack/third-party/start/tagbar
    $ git pull origin master


### [NerdTree](https://github.com/scrooloose/nerdtree)


I've also added the [Nerdtree tab plugin](https://github.com/jistr/vim-nerdtree-tabs) ([via](stackoverflow.com/questions/2283417/vim-and-nerd-tree-can-nerd-tree-persist-across-tabs-in-macvim))

I set this up with:

    $ git submodule add -b master https://github.com/scrooloose/nerdtree.git bundle/nerdtree
    $ git submodule add -b master https://github.com/jistr/vim-nerdtree-tabs.git bundle/nerdtree-tabs


* 5-17-2016 - I'm currently trying to use [netrw instead of NERDTree](https://blog.mozhu.info/vimmers-you-dont-need-nerdtree-18f627b561c3#.6p2s7r8ir)
* 5-18-2016 - I couldn't do it, I re-activated NERDTree


### [Commentify](https://github.com/Jaymon/vim-commentify)


A really lightweight plugin to comment/uncomment code, basically a lightweight
[NERD Commenter](https://github.com/scrooloose/nerdcommenter) or an updated [comments](http://www.vim.org/scripts/script.php?script_id=1528).

I set this up with:

    $ git submodule add -b master git@github.com:Jaymon/vim-commentify.git bundle/commentify


### [Surround](https://github.com/tpope/vim-surround)

While moving this into the `pack` directory I was going to just disable it, but I've decided to give it one final final chance. I always forget this exists.

trying this again. I've had this bundle for years and never remember the shortcut to run it, but I decided to keep it one more time.

I'm pretty sure this uses `s` as the command to "surround".

I set this up with:

    $ git submodule add -b master https://github.com/tpope/vim-surround.git bundle/surround


### Python

Currently an internal syntax plugin that brings together the good parts of some other plugins into a python environment that I like to use.


### Utils

Internal plugin that contains misc functions and commands that I love, compiled from around the internet, and maybe even kind of written by me, in order to make this a little more portable.


### [SnipMate](https://github.com/garbas/vim-snipmate)

This actually has dependencies, so setup was a bit more involved:

    $ git submodule add -b master https://github.com/garbas/vim-snipmate.git pack/third-party/start/snipmate
    $ git submodule add -b master https://github.com/MarcWeber/vim-addon-mw-utils.git pack/third-party/start/addon_mw_utils

I thought about using [ultisnips](https://github.com/SirVer/ultisnips) instead but that requires python and I prefer to use pure vimscript plugins when I can.

[vim-snippets](https://github.com/honza/vim-snippets/blob/master/snippets/python.snippets) contains lots of snippet files for reference.

When in *insert* mode you can do `ctrl-R tab` (`<C-R><Tab>`) to get all the matching snippets. I've also added `:Snippets` to open the corresponding `$VIMHOME/snippets/<FILETYPE>.snippets` file.


#### April 14, 2025

I removed `tlib` since I've never used the `:SnipMateOpenSnippetFiles` command and it doesn't make any sense to keep a whole dependency around for it

    $ git rm pack/third-party/start/tlib

I also updated the installation instructions.


### Colcol

April 14, 2025 - I have no idea when I added this, it's not a submodule, so I'm the one that added it and it's actually pretty cool. It places a `ColorColumn` (a column background color that goes from the top of the file to the bottom of the file) at the cursor position

* `<LEADER>c` - toggle a color column at the current cursor position
* `<LEADER>C` - toggle off all color columns, be careful with this as it will turn off the preset ones at 80 and 120 also.


-------------------------------------------------------------------------------

## Warnings

This currently does not work as well on the console version of Vim, I've spent time tuning the *GUI* version,
not so much the console version.


