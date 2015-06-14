# Python vim

This is my prefered python environment for Vim. I've taken what I think are the good parts from numerous places, thrown some glitter on them and created this syntax plugin.

## The Good parts

### Python syntax

https://github.com/hdima/python-syntax

Looks like they've stopped updating [vim scripts](http://www.vim.org/scripts/script.php?script_id=790) in favor of the github repo. 

update it:

    $ curl https://raw.githubusercontent.com/hdima/python-syntax/master/syntax/python.vim -o ~/.vim/bundle/python/syntax/python.vim

This file should never be touched by me, so it should be safe to update


### Pymode

https://github.com/klen/python-mode

Some of the stuff from Pymode like the motion commands are great.

This will update motion:

    $ curl -L https://github.com/klen/python-mode/raw/develop/after/ftplugin/python.vim -o ~/.vim/bundle/python/after/ftplugin/python.vim
    $ curl -L https://raw.githubusercontent.com/klen/python-mode/develop/autoload/pymode/motion.vim -o ~/.vim/bundle/python/autoload/pymode/motion.vim

This will update indentation:

    $ curl -L https://github.com/klen/python-mode/raw/develop/autoload/pymode/indent.vim -o ~/.vim/bundle/python/autoload/pymode/indent.vim
    $ curl -L https://github.com/klen/python-mode/raw/develop/after/indent/python.vim -o ~/.vim/bundle/python/after/indent/python.vim

These files should never be touched by me, so they should be safe to update


### Python indent

This hasn't been updated in a decade, so...

http://www.vim.org/scripts/script.php?script_id=974

http://henry.precheur.org/vim/python

**NOTE** -- I've replaced this with Pymode's indentaion implementation.


## Installation

Use Pathogen, and then run these (if you want it to be a submodule):

    $ cd path/to/.vim
    $ git submodule add -b master <ADD GITHUB CLONE> bundle/python

