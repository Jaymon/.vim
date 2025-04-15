# History

Notes about changes I've made and things like that.

-------------------------------------------------------------------------------

### Installation on Windows 

I haven't used Windows for development in over 10 years, so I'm not sure if this would still work

1. Create `%HOMEPATH%\vimfiles`

2. cd into `%HOMEPATH%\vimfiles`

3. clone the repo

    $ git clone [repo] .

4. make a symlink for the `vimrc` and `gvimrc` files (you need an admin console cmd shell for this):

    ```
    $ mklink %HOMEPATH%\\_vimrc %HOMEPATH%\\vimfiles\\vimrc
    $ mklink %HOMEPATH%\\_gvimrc %HOMEPATH%\\vimfiles\\gvimrc
    ```

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



### Rainbow Parenthesis

https://github.com/luochen1990/rainbow

I've actually installed this previously, but decided to give it another try (6-20-2019)

    $ git submodule add -b master https://github.com/luochen1990/rainbow.git bundle/rainbow


#### Previous comments

> This doesn't work in new tabs/buffers, and it took me like a month to notice it didn't work in the buffers, so I figured I didn't need it
>
> http://www.vim.org/scripts/script.php?script_id=3772

Disabled this again on 9-2-2019 because it totally borks php syntax highlighting and it was pretty subtle with python so I doubt I'll really miss it


### [Pydiction](https://github.com/rkulla/pydiction)

#### April 14, 2025

I removed this with:

```
$ git rm pack/third-party/opt/pydiction
```

It didn't even work and my `plugin/pydiction.vim` didn't even point to the right path, so I figured I haven't used this plugin in years and years.


#### Original description

Moved to `pack/third-party/opt` on 3-5-2023. I just don't use this much.

Setup:

    $ git submodule add -b master https://github.com/rkulla/pydiction.git bundle/pydiction


### [CtrlP](https://github.com/kien/ctrlp.vim)

#### April 14, 2025

I just loaded this plugin with `:packadd ctrlp` and did `\r` and did some searches, it's really cool but I just don't open files this way, and having to move to the arrow keys to actually select the file was annoying, I use NERDTree after I open the first file.

```
$ git rm pack/third-party/opt/ctrlp
$ rm plugin/ctrlp.vim
```


#### Original description

Moved to `pack/third-party/opt` on 3-5-2023, I don't think I've ever used this plugin, this just isn't how I open files. If I don't miss it then I will probably remove it.


found [via](http://www.bestofvim.com/plugin/ctrl-p/)

configured to always open in a tab using [this](https://github.com/kien/ctrlp.vim/issues/160)

I set this up with:

    $ git submodule add -b master https://github.com/kien/ctrlp.vim.git bundle/ctrlp

