# Plugin Directory

This directory used to be for Vim plugins, but that functionality has been superseded by `pack/*/start` and looking at `:scriptnames` it appears files loaded in this directory are loaded before `pack/*/start` so I decided to repurpose this directory for plugin specific configuration.

On March 6, 2023 I moved all the plugin specific configuration I had in my `vimrc` into separate files in this directory, and that is how I plan on using it going forward. If I install a plugin and need to configure it, I should create a matching `plugin/<PLUGIN-NAME>.vim` file and add the configuration there. This should roughly be the same as adding the configuration to the end of my `vimrc`.

I first read about using the `plugin` directory for this [here](https://vi.stackexchange.com/a/26854).

## Other Solutions

I also thought of adding these configuration files into the `autoload` directory since it appears that gets loaded right after the `vimrc`. But I decided I liked the idea of plugin configuration going into the `plugin` directory.

Another option was to create an arbitrary directory, like `vimrc.d` and [then sourcing all the files](https://vi.stackexchange.com/a/5443) in that directory at the end of my vimrc using the `source` command, something like:

```vim
" Source all files in the 'vimrc.d' directory
for file in glob('$VIMHOME/vimrc.d/*.vim')
    execute 'source' file
endfor
```


## Search and links

* initialize vim plugins outside of vimrc
