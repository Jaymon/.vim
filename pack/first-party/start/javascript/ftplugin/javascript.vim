
" Only load this when no other was loaded.
if exists("b:did_ftplugin_javascript")
    finish
endif
let b:did_ftplugin_javascript = 1


function! RanLinter(channel)
  " I was trying to delete the newline so `done` stays on the same line, it
  " didn't work
  "1echow "\x08\x08 done"
  "1echow "done"
  "echomsg "done"
  "redraw!
  edit
  "source %

endfunc

"function! RunningLinter(channel, msg) 
"  "while ch_status(a:channel, {"part": "out"}) == "buffered"
"  "echomsg ch_read(a:channel)
"  "endwhile
"  "echom "."
"endfunction


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
    "call job_start(cmd, {"close_cb": "RanLinter", "callback": "RunningLinter", "out_timeout": 10})
    call job_start(cmd, {"close_cb": "RanLinter"})

    "echom "Linting"
    "echom cmd
    "silent! execute "!" . cmd
    "echom "Done running: " . cmd

  endif

endfunction


"autocmd BufWritePost * :echo "File saved!"
autocmd BufWritePost * call RunLinter()

