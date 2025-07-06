# Hilinks

## Usage

To activate it for the token under the cursor:

```
:HLT
```

Once you hit enter it will run the command and print out syntax and highlight stack.


## Notes

The version I'm using is from [here](https://raw.githubusercontent.com/gerw/vim-HiLinkTrace/refs/heads/master/plugin/hilinks.vim), I just downloaded it and created the plugin.

I first tried to use a `.vba` version but it didn't work even though it seems like it was a later version. This version worked though and did what I wanted which was to show the highlighting trace and confirm that my own custom code that runs in my status bar isn't completely accurate for certain syntaxes (cough, typescript's builtin syntax, cough).

### Links and searches

* [via](https://www.reddit.com/r/vim/comments/4nxeyq/comment/d48q8kl/) - the hilinks script that works I found from this comment.
* get all information about vim syntax at cursor
* [Identify the syntax highlighting group used at the cursor](https://vim.fandom.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor) - this mentions hilink
* [Hilinks](http://www.drchip.org/astronaut/vim/index.html#HILINKS) - this is where I found the hilinks.vba I originally tried to use.
* [vim help](http://www.drchip.org/astronaut/vim/doc/hilinks.txt.html)


#### July 3, 2025


* [SyntaxAttr.vim : Show syntax highlighting attributes of character under cursor](https://www.vim.org/scripts/script.php?script_id=383) - this looks like a similar plugin and might be worth looking at.