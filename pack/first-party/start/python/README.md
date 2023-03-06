# Python vim

This is my preferred python environment for Vim. I've taken what I think are the good parts from numerous places, thrown some glitter on them and created this syntax plugin.

You can customize values for startup in the `bundle/python/ftplugin/python.vim` file. For example, that's where you would set whether you wanted space errors to be highlighted.

You can find the Syntax file at:

```
/Applications/MacVim.app/Contents/Resources/vim/runtime/syntax/python.vim
```

And the indent file at:

```
/Applications/MacVim.app/Contents/Resources/vim/runtime/indent/python.vim
```


## The Good parts

### Pymode

https://github.com/klen/python-mode

Some of the stuff from Pymode like the motion commands are great.

This will update motion:

    $ curl -L https://github.com/klen/python-mode/raw/develop/after/ftplugin/python.vim -o ~/.vim/bundle/python/after/ftplugin/python.vim
    $ curl -L https://raw.githubusercontent.com/klen/python-mode/develop/autoload/pymode/motion.vim -o ~/.vim/bundle/python/autoload/pymode/motion.vim

These files should never be touched by me, so they should be safe to update, but I do add some configuration in `<PYTHON MODULE>/ftplugin/python.vim` that depends on these files, so if they are updated I will need to make sure that configuration is updated also.


### Python indent

This will update indentation:

    $ curl -L https://github.com/klen/python-mode/raw/develop/autoload/pymode/indent.vim -o ~/.vim/bundle/python/autoload/pymode/indent.vim
    $ curl -L https://github.com/klen/python-mode/raw/develop/after/indent/python.vim -o ~/.vim/bundle/python/after/indent/python.vim

On January 4, 2022 I update the `indent.vim` file, so be careful replacing it willy-nilly. I marked where in the file I modified it.


### python_match

[via](https://vim.sourceforge.io/scripts/script.php?script_id=386)


## Installation

Use Pathogen, and then run these (if you want it to be a submodule):

    $ cd path/to/.vim
    $ git submodule add -b master <ADD GITHUB CLONE> bundle/python

## Links

* https://github.com/sheerun/vim-polyglot - bundle that has syntax and indent for a bunch of languages. I checked out the python and it was using outdated stuff, so this doesn't inspire me to use it. Good place to start when I'm looking to highlight a new language though.
* https://github.com/Vimjas/vim-python-pep8-indent - A more opinionated vim indent script, but I'm not sure I like the author's opinions.


## Dead

### Python syntax

I removed this file and moved to the builtin vim syntax file on Jan 5, 2023

https://github.com/vim-python/python-syntax


Previously, I was using [this syntax file](https://github.com/hdima/python-syntax) but they stopped updating it, after stopping the updates to the [vim scripts](http://www.vim.org/scripts/script.php?script_id=790), but an [issue pointed to a new repo](https://github.com/hdima/python-syntax/issues/62), so as of October 26, 2021, I've moved to the new repo.

To update the syntax file:

    $ curl "https://raw.githubusercontent.com/vim-python/python-syntax/master/syntax/python.vim" -o ~/.vim/bundle/python/syntax/python.vim

This file should never be touched by me, so it should be safe to update