# Python vim

This is my prefered python environment for Vim. I've taken what I think are the good parts from numerous places, threw some glitter on them and created this syntax plugin.

## The Good parts

### Python syntax

https://github.com/hdima/python-syntax

Looks like they've stopped updating [vim scripts](http://www.vim.org/scripts/script.php?script_id=790) in favor of the github repo. 

update it:

    $ curl https://raw.githubusercontent.com/hdima/python-syntax/master/syntax/python.vim -o ~/.vim/bundle/python/syntax/python.vim


### Python indent

This hasn't been updated in a decade, so 

http://www.vim.org/scripts/script.php?script_id=974


### Pymode

Some of the stuff from Pymode like the motion commands are great.

    $ curl https://github.com/klen/python-mode/raw/develop/after/ftplugin/python.vim -o ~/.vim/bundle/python/after/ftplugin/python.vim
    $ curl https://raw.githubusercontent.com/klen/python-mode/develop/autoload/pymode/motion.vim -o ~/.vim/bundle/python/autoload/pymode/motion.vim

    $ curl https://github.com/klen/python-mode/raw/develop/autoload/pymode/indent.vim -o ~/.vim/bundle/python/autoload/pymode/indent.vim
    $ curl https://github.com/klen/python-mode/raw/develop/after/indent/python.vim -o ~/.vim/bundle/python/after/indent/python.vim
