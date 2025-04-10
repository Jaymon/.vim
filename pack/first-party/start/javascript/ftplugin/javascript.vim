
" Only load this when no other was loaded.
if exists("g:loaded_javascript_ftplugin")
    finish
endif
let g:loaded_javascript_ftplugin = "v0.1"


""
" This is called when the linter job is finished, it is defined in `job_start`
""
function! RanLinter(channel)
  " save the cursor position because `edit` will sometimes change it but it's
  " maddeningly incosistent on when it does it and where it puts it
  let view = winsaveview()
  "let save_pos = getpos('.')

  " refresh the buffer so the changes are reflected
  edit

  " restore the cursor position
  "call setpos('.', save_pos)
  " Restore scroll/view position
  call winrestview(view)

endfunc


""
" Run a linter on the given buffer's filepath. Currently the linter is
" hardcoded to eslint found in the current directory
""
function! RunLinter()
  let binscript = "./node_modules/eslint/bin/eslint.js"
  let filepath = expand('%:p')

  if filereadable(binscript)
    let cmd = "node \"" . binscript . "\" --fix --quiet \"" . filepath . "\""

    " print the command in a window at the bottom of the buffer for 1 second
    1echow cmd

    " https://vimhelp.org/channel.txt.html#job-start
    call job_start(cmd, {"close_cb": "RanLinter"})

  endif

endfunction

augroup javascript_linter
  " Clear autocommands in this group, when I was opening up more buffers/files
  " I was noticing that my linter call was running multiple times, this is
  " because each new buffer added a new autocmd, this makes sure that doesn't
  " happen anymore
  autocmd!

  autocmd BufWritePost * call RunLinter()

augroup END

