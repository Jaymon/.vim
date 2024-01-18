# Indentify Vim Plugin

Auto-discover a file's actual indentation.

This will infer the indent of the file based on the first N lines of the file, the idea is that it will check the indent of each of the first N lines of the file and find the minimum `tabstop` count and then set `tabstop` and related settings to that value.

I've wanted to do this for a long time but never bothered to figure out how to do it because Vim plugins are often inscrutable and I wasn't sure how to approach the problem.

https://psy.swansea.ac.uk/staff/carter/vim/vim_indent.htm


## Installation

You can just dump this directory into `<VIMHOME>/pack/*/start/` and it should auto-load. You can verify by opening a file and running:

    :scriptnames
    
You should see the `indentify.vim` file loaded somewhere in the list.