# Vim Packages

This directory replaces [pathogen](https://github.com/tpope/vim-pathogen) for me.

Vim's internal package manager expects the directory to be setup like `pack/*/{start|opt}` where the `*` can basically be whatever you want, and so I've configured the `pack` directory to have these directories:

* `pack/first-party/start` - Any bespoke packages, these are packages I've created specifically for this repo.
* `pack/third-party/start` - These are external git submodules pointing to vim plugins I actively use.
* `pack/third-party/opt` - I placed any external git submodules I don't really use anymore into this directory. At some point I'll probably delete plugins from this module.


## Vim specific help

To learn about packages:

```
:help packages
```

If you need to load a package in an `opt` directory:

```
:packadd <PLUGIN-NAME>
```

To [generate all the helptags](https://vi.stackexchange.com/a/9523):

```
:helptags ALL
```


## Git help

To [move a submodule](https://stackoverflow.com/a/6310246):

```
$ git mv old/submodule/path new/submodule/path
```

To [remove a submodule](https://stackoverflow.com/a/1260982):

```
$ git rm submodule/path
```



## Links and Searches

* https://dev.to/iggredible/how-to-use-vim-packages-3gil
* https://learnvim.irian.to/customize/vim_packages
* https://shapeshed.com/vim-packages/
* vims builtin package manager
* `pathogen#infect`
* [load order](https://vi.stackexchange.com/a/24478)
* vim load plugin directory before pack directory