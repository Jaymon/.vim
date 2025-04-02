
""
" Run a linter on the given buffer's filepath. Currently the linter is
" hardcoded to eslint found in the current directory
""
function! RunLinter()
  let binscript = "./node_modules/eslint/bin/eslint.js"
  let filepath = expand('%:p')

  if filereadable(binscript)
    let cmd = "node \"" . binscript . "\" --fix --quiet \"" . filepath . "\""
    "echom cmd
    silent! execute "!" . cmd

  endif

endfunction


"autocmd BufWritePost * :echo "File saved!"
autocmd BufWritePost * call RunLinter()

