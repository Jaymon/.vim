# Environment Setup

When env#setup() is placed in your .vimrc, this will setup some environment variables that you can then use in your script.

Variables this script sets:

* `$VIMHOME` - will point to your vim home directory, usually `~/.vim` on Linux/macOS type systems and `~/vimfiles` on Windows.
* `$VIMTEMP` - will point to a temp dir that vim can use, usually `/tmp` on Linux type systems and some user specific temp dir on Windows, and some random folder on macOS


## How to use?

I put this as the very first command of my .vimrc:

```
call env#setup()
```

That's it, if this is correctly placed in the `<VIMHOME>/pack` directory then it should load automatically.
