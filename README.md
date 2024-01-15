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


### [Pathogen](https://github.com/tpope/vim-pathogen)

Moved to `pack/third-party/opt` on 3-2023, I don't think this is needed anymore because I'm now using Vim's built-in package (see `:help package`) functionality now.

I think pretty much every vim user on the planet uses this plugin.

I set this up with:

    $ git submodule add -b master https://github.com/tpope/vim-pathogen.git bundle/pathogen


### [Tagbar](https://github.com/preservim/tagbar)

This replaced Taglist because I like the hierarchical code tree better.

It depends on [ctags](https://github.com/universal-ctags/ctags), which can be installed on mac using brew:

    $ brew install universal-ctags

I set this up with:

    $ git submodule add -b master https://github.com/majutsushi/tagbar.git bundle/tagbar


### [NerdTree](https://github.com/scrooloose/nerdtree)


I've also added the [Nerdtree tab plugin](https://github.com/jistr/vim-nerdtree-tabs) ([via](stackoverflow.com/questions/2283417/vim-and-nerd-tree-can-nerd-tree-persist-across-tabs-in-macvim))

I set this up with:

    $ git submodule add -b master https://github.com/scrooloose/nerdtree.git bundle/nerdtree
    $ git submodule add -b master https://github.com/jistr/vim-nerdtree-tabs.git bundle/nerdtree-tabs


* 5-17-2016 - I'm currently trying to use [netrw instead of NERDTree](https://blog.mozhu.info/vimmers-you-dont-need-nerdtree-18f627b561c3#.6p2s7r8ir)
* 5-18-2016 - I couldn't do it, I re-activated NERDTree


### [CtrlP](https://github.com/kien/ctrlp.vim)

Moved to `pack/third-party/opt` on 3-5-2023, I don't think I've ever used this plugin, this just isn't how I open files. If I don't miss it then I will probably remove it.


found [via](http://www.bestofvim.com/plugin/ctrl-p/)

configured to always open in a tab using [this](https://github.com/kien/ctrlp.vim/issues/160)

I set this up with:

    $ git submodule add -b master https://github.com/kien/ctrlp.vim.git bundle/ctrlp


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


### [markdown](https://github.com/tpope/vim-markdown)

From the repo:

> This is the development version of Vim's included syntax highlighting and filetype plugins for Markdown. Generally you don't need to install these if you are running a recent version of Vim.

So I removed this on 3-5-2023

I set this up with:

    $ git submodule add -b master https://github.com/tpope/vim-markdown.git bundle/markdown


### Python

Currently an internal syntax plugin that brings together the good parts of some other plugins into a python environment that I like to use.


### Utils

Internal plugin that contains misc functions and commands that I love, compiled from around the internet, and maybe even kind of written by me, in order to make this a little more portable.


### [Pydiction](https://github.com/rkulla/pydiction)

Moved to `pack/third-party/opt` on 3-5-2023. I just don't use this much.

Setup:

    $ git submodule add -b master https://github.com/rkulla/pydiction.git bundle/pydiction


### [SnipMate](https://github.com/garbas/vim-snipmate)

This actually has dependencies, so setup was a bit more involved:

    $ git submodule add -b master https://github.com/tomtom/tlib_vim.git bundle/tlib
    $ git submodule add -b master https://github.com/MarcWeber/vim-addon-mw-utils.git bundle/addon_mw_utils
    $ git submodule add -b master https://github.com/garbas/vim-snipmate.git bundle/snipmate

I thought about using [ultisnips](https://github.com/SirVer/ultisnips) instead but that requires python and I prefer to use pure vimscript plugins when I can.

[vim-snippets](https://github.com/honza/vim-snippets/blob/master/snippets/python.snippets) contains lots of snippet files for reference.

When in *insert* mode you can do `ctrl-R tab` (`<C-R><Tab>`) to get all the matching snippets. I've also added `:Snippets` to open the corresponding `$VIMHOME/snippets/<FILETYPE>.snippets` file.


### [Applescript syntax](https://www.vim.org/scripts/script.php?script_id=1736)

Moved to `pack/third-party/opt` on 3-5-2023. I don't think I'll miss it so I will most likely delete it in the future.

    $ git submodule add -b master https://github.com/vim-scripts/applescript.vim bundle/applescript


* search: vim applescript syntax
* Added 2019-08-20.


-------------------------------------------------------------------------------

## Warnings

This currently does not work as well on the console version of Vim, I've spent time tuning the *GUI* version,
not so much the console version.


