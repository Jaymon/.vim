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

-------------------------------------------------------------------------------

## Plugins

### Third party

Plugins are found in:

* `pack` - this is where I put first-party and manually installed third-party plugins.
* `plugged` - this is where the [vim-plug](https://github.com/junegunn/vim-plug) plugins configured in `vimrc` are located.
* `plugin` - handles plugin specific configuration.


#### [Tagbar](https://github.com/preservim/tagbar)

Managed by vim-plug.

This replaced Taglist because I like the hierarchical code tree better.

It depends on [ctags](https://github.com/universal-ctags/ctags), which can be installed on mac using brew:

    $ brew install universal-ctags


#### [NerdTree](https://github.com/scrooloose/nerdtree)

Managed by vim-plug


#### [Commentify](https://github.com/Jaymon/vim-commentify)

Managed by vim-plug


A really lightweight plugin to comment/uncomment code, basically a lightweight
[NERD Commenter](https://github.com/scrooloose/nerdcommenter) or an updated [comments](http://www.vim.org/scripts/script.php?script_id=1528).


#### [Surround](https://github.com/tpope/vim-surround)

Managed by vim-plug

visual surround:

* select the text in visual mode
* press `S` (capital S) and then the character you want to surround the selection with

Surround current word:

* `ysiw<CHAR>` - so to surround the current word with a double quote: `ysiw"`

Surround current non-whitespace under selection:

* `ysiW<CHAR>`

Switch `<CHAR1>` to `<CHAR2>`:

* `cs<CHAR1><CHAR2>`

Remove surrounding `<CHAR>`:

* `ds<CHAR>`


#### Colcol

Manually installed

April 14, 2025 - I have no idea when I added this, it's not a submodule, so I'm the one that added it and it's actually pretty cool. It places a `ColorColumn` (a column background color that goes from the top of the file to the bottom of the file) at the cursor position

* `<LEADER>c` - toggle a color column at the current cursor position
* `<LEADER>C` - toggle off all color columns, be careful with this as it will turn off the preset ones at 80 and 120 also.


#### Hilinks

Manually installed

See highlights for text under cursor:

```
:HLT
```


#### [Vim-Plug](https://github.com/junegunn/vim-plug)

Manually installed, manages other plugins. Configured in `vimrc`.

[Usage](https://github.com/junegunn/vim-plug#usage):

* `:PlugInstall` to install the plugins
* `:PlugUpdate` to install or update the plugins
* `:PlugDiff` to review the changes from the last update
* `:PlugClean` to remove plugins no longer in the list


#### [Vim-LSP](https://github.com/prabirshrestha/vim-lsp)

Managed by vim-plug.

I installed [vim-lsp-settings](https://github.com/mattn/vim-lsp-settings) plugin (also managed by vim-plug) to manage the LSP servers, you install a server like this:

```
:LspInstallServer <NAME>
```

The [names you can install can be found here](https://github.com/mattn/vim-lsp-settings#supported-languages).

[This](https://github.com/python-lsp/python-lsp-server) is the Python LSP server I installed:

```
:LspInstallServer pylsp
```


### First party

#### Python

Currently an internal syntax plugin that brings together the good parts of some other plugins into a python environment that I like to use.


#### Utils

Internal plugin that contains misc functions and commands that I love, compiled from around the internet, and maybe even kind of written by me, in order to make this a little more portable.


#### Env

Sets up certain paths so they can be used in configuration.


#### Indentify

Auto sets tabstop depending on the indentation of the file.


-------------------------------------------------------------------------------

## Warnings

This currently does not work as well on the console version of Vim, I've spent time tuning the *GUI* version, not so much the console version.


