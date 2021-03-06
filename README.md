# My VIM Environment Settings Files

This is here for my convenience so I can easily keep my vim environment consistent across multiple machines.

There are some original things though that might be useful for people, like the `syntax/php.vim` file that I think is easier to understand than the traditional php syntax file.

-------------------------------------------------------------------------------

## Plugins

to update all the submodules:

    $ git submodule foreach git pull origin master


### Pathogen

I think pretty much every vim user on the planet uses this plugin.

https://github.com/tpope/vim-pathogen

I set this up with:

    $ git submodule add -b master https://github.com/tpope/vim-pathogen.git bundle/pathogen


### Tagbar

This replaced Taglist because I like the hierarchical code tree better

http://majutsushi.github.com/tagbar/

I set this up with:

    $ git submodule add -b master https://github.com/majutsushi/tagbar.git bundle/tagbar


### NerdTree

https://github.com/scrooloose/nerdtree

I've also added the Nerdtree tab plugin

https://github.com/jistr/vim-nerdtree-tabs

via: stackoverflow.com/questions/2283417/vim-and-nerd-tree-can-nerd-tree-persist-across-tabs-in-macvim

I set this up with:

    $ git submodule add -b master https://github.com/scrooloose/nerdtree.git bundle/nerdtree
    $ git submodule add -b master https://github.com/jistr/vim-nerdtree-tabs.git bundle/nerdtree-tabs


5-17-2016 - I'm currently trying to use netrw instead of NERDTree:
5-18-2016 - I couldn't do it, I re-activated NERDTree

#### Netrw info

https://blog.mozhu.info/vimmers-you-dont-need-nerdtree-18f627b561c3#.6p2s7r8ir


### CtrlP

https://github.com/kien/ctrlp.vim

found via: http://www.bestofvim.com/plugin/ctrl-p/

configured to always open in a tab using this: https://github.com/kien/ctrlp.vim/issues/160

I set this up with:

    $ git submodule add -b master https://github.com/kien/ctrlp.vim.git bundle/ctrlp


### Commentify

https://github.com/Jaymon/vim-commentify

A really lightweight plugin to comment/uncomment code, basically a lightweight
[NERD Commenter](https://github.com/scrooloose/nerdcommenter) or an updated
[comments] (http://www.vim.org/scripts/script.php?script_id=1528)

I set this up with:

    $ git submodule add -b master git@github.com:Jaymon/vim-commentify.git bundle/commentify


### Surround

trying this again. I've had this bundle for years and never remember the shortcut to run it, but I decided to keep it one more time.

I'm pretty sure this uses `s` as the command to "surround".

https://github.com/tpope/vim-surround

I set this up with:

    $ git submodule add -b master https://github.com/tpope/vim-surround.git bundle/surround


### markdown

https://github.com/tpope/vim-markdown

I set this up with:

    $ git submodule add -b master https://github.com/tpope/vim-markdown.git bundle/markdown


### Python

Currently an internal syntax plugin that brings together the good parts of some other plugins into a python environment that I like to use.


### Utils

Internal plugin that contains misc functions and commands that I love, compiled from around the internet, and maybe even kind of written by me, in order to make this a little more portable.


### Pydiction

https://github.com/rkulla/pydiction

Setup:

    $ git submodule add -b master https://github.com/rkulla/pydiction.git bundle/pydiction


### SnipMate

https://github.com/garbas/vim-snipmate

This actually has dependencies, so setup was a bit more involved:

    $ git submodule add -b master https://github.com/tomtom/tlib_vim.git bundle/tlib
    $ git submodule add -b master https://github.com/MarcWeber/vim-addon-mw-utils.git bundle/addon_mw_utils
    $ git submodule add -b master https://github.com/garbas/vim-snipmate.git bundle/snipmate

I thought about using [ultisnips](https://github.com/SirVer/ultisnips) instead but that requires python and I prefer to use pure vimscript plugins when I can.

[vim-snippets](https://github.com/honza/vim-snippets/blob/master/snippets/python.snippets) contains lots of snippet files for referencea.

When in *insert* mode you can do `ctrl-R tab` (`<C-R><Tab>`) to get all the matching snippets. I've also added `:Snippets` to open the corresponding `$VIMHOME/snippets/<FILETYPE>.snippets` file.


### Rainbow Parenthesis

https://github.com/luochen1990/rainbow

I've actually installed this previously, but decided to give it another try (6-20-2019)

    $ git submodule add -b master https://github.com/luochen1990/rainbow.git bundle/rainbow


#### Previous comments

> This doesn't work in new tabs/buffers, and it took me like a month to notice it didn't work in the buffers, so I figured I didn't need it
>
> http://www.vim.org/scripts/script.php?script_id=3772

Disabled this again on 9-2-2019 because it totally borks php syntax highlighting and it was pretty subtle with python so I doubt I'll really miss it


### Applescript syntax

[permalink](https://www.vim.org/scripts/script.php?script_id=1736)

    $ git submodule add -b master https://github.com/vim-scripts/applescript.vim bundle/applescript

search: vim applescript syntax

Added 2019-08-20.


-------------------------------------------------------------------------------

## Install

### In Mac or Linux

1. Create `$HOME/.vim`

2. cd into `$HOME/.vim`

3. clone the repo

        git clone [repo] .

4. Symlink `$HOME/.vim/vimrc` and `$HOME/.vim/gvimrc`

        ln -s $HOME/.vim/vimrc $HOME/.vimrc
        ln -s $HOME/.vim/gvimrc $HOME/.gvimrc

### In Windows 

1. Create `%HOMEPATH%\vimfiles`

2. cd into `%HOMEPATH%\vimfiles`

3. clone the repo

        git clone [repo] .

4. make a symlink for the `vimrc` and `gvimrc` files (you need an admin console cmd shell for this):

        mklink %HOMEPATH%\\_vimrc %HOMEPATH%\\vimfiles\\vimrc
        mklink %HOMEPATH%\\_gvimrc %HOMEPATH%\\vimfiles\\gvimrc


-------------------------------------------------------------------------------

## Warnings

This currently does not work as well on the console version of Vim, I've spent time tuning the *GUI* version,
not so much the console version.

## Plugins I've thought about using

### Python Mode

https://github.com/klen/python-mode

### Vim Sneak

https://github.com/justinmk/vim-sneak
discovered via: https://news.ycombinator.com/item?id=11700906

### Vim vertical

https://github.com/rbong/vim-vertical

### plugin to make developing plugins easier

https://github.com/tpope/vim-scriptease

https://github.com/xolox/vim-easytags
via: http://stackoverflow.com/questions/1224838/vim-php-omni-completion

https://github.com/pangloss/vim-javascript

https://github.com/nathanaelkane/vim-indent-guides


-------------------------------------------------------------------------------

## Things I don't like

### Mac

For some reason sizing the Macvim window on startup doesn't work, I have no idea why


-------------------------------------------------------------------------------

## Plugins I used and then removed

### Taglist

http://www.vim.org/scripts/script.php?script_id=273

I used tagbar more, no sense in having both anymore


### Markdown

I actually don't know what happened to this, the folder was empty which makes me
think I forgot to add the file to git, and I originally installed it on an os I no longer
use. *Sigh*

I went with this markdown syntax plugin:

https://github.com/tpope/vim-markdown

I had originally installed:

http://www.vim.org/scripts/script.php?script_id=1242

but it would italicize the rest of the body if the word had an underscore in it (eg, sn_id caused 
everything after the underscore until the end to be italicized) while the one I went with
just marks it as an error, which is still not ideal, but better.


### syntax/php.vim

The php syntax file seemed way too complicated to me, so I rolled my own using this syntax
file as a base

https://github.com/StanAngeloff/php.vim
https://github.com/EvanDotPro/vim-php-syntax-check
http://www.vim.org/scripts/script.php?script_id=2874


### comments

http://www.vim.org/scripts/script.php?script_id=1528

I replaced this with my commentify plugin.

#### What I had in my vimrc

```vimL
""" comments.vim
"A more elaborate comment set up. Use Ctr-C to comment and Ctr-x to uncomment
" This will detect file types and use oneline comments accordingle. Cool
" because you visually select regions and comment/uncomment the whole region.
" works with marked regions to.
" to activate, just place it in your plugins dir
" https://github.com/vim-scripts/comments.vim
" http://www.vim.org/scripts/script.php?script_id=1528
```


### PHP Doc

I am not doing a lot of php right now, and when I did, I hardly ever used this plugin since it wasn't as flexible as I would've liked and so I spent a lot of time deleting things it put in

https://github.com/sumpygump/php-documentor-vim
via: http://stackoverflow.com/questions/7603446/vim-insert-phpdoc-automatically


### PHP support plugins

In order to make php support better by default, you could use this gist:
https://gist.github.com/ecoleman/1525027

These links might also help:
http://mwop.net/blog/134-exuberant-ctags-with-PHP-in-Vim.html
http://vim-taglist.sourceforge.net/extend.html

but I've added some other plugins to make tagbar work better with php. As discussed on this page:
http://stackoverflow.com/questions/11290352/vim-hack-ctags-or-tweak-tagbar-for-better-php-support

- Tagbar-phpctags

https://github.com/techlivezheng/tagbar-phpctags
http://www.vim.org/scripts/script.php?script_id=4125

- phpctags

https://github.com/techlivezheng/phpctags

You might need to install the dependencies for this, so you can get in the directory that contains this plugin:

    $ cd ~/.vim/bundle/phpctags

and run:

    $ curl -s http://getcomposer.org/installer | php -d detect_unicode=Off
    $ php composer.phar install

That will create a `vendor` directory that contains the dependencies and a `composer.lock` file, you can then delete the downloaded `composer.phar` file.

Php specific configuration that was in `.vimrc`:

```vimL
if has("win32")
  " for some reason, tagbar won't work if there are quotes around the path
  let g:tagbar_ctags_bin = $VIMHOME . '\bin\ctags.exe'
  let g:tagbar_phpctags_bin = $VIMHOME . '\bin\phpctags.bat'
else
  " ctags should be on the PATH for everything else
  let g:tagbar_phpctags_bin = $VIMHOME . '/bundle/phpctags/phpctags'
endif
```


### Camel Case Motion

https://github.com/bkad/CamelCaseMotion

see also:
http://vim.wikia.com/wiki/Moving_through_camel_case_words
http://www.vim.org/scripts/script.php?script_id=1905
http://stackoverflow.com/questions/8949317/moving-through-camelcase-words-in-vim

I configured this plugin in my `.vimrc` like this:

```vimL
" configure camel case motion
map <S-W> <Plug>CamelCaseMotion_w
map <S-B> <Plug>CamelCaseMotion_b
map <S-E> <Plug>CamelCaseMotion_e
```

