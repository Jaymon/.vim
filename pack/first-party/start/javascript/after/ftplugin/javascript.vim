
" Only load this when no other was loaded.
if exists("g:loaded_javascript_after_ftplugin")
    finish
endif
let g:loaded_javascript_after_ftplugin = "v0.2"


augroup javascript_after_ftplugin
  " Clear autocommands in this group, when I was opening up more buffers/files
  " I was noticing that my linter call was running multiple times, this is
  " because each new buffer added a new autocmd, this makes sure that doesn't
  " happen anymore
  autocmd!
augroup END


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


augroup javascript_after_ftplugin
  autocmd BufWritePost * call RunLinter()
augroup END


if !exists('g:no_plugin_maps') && !exists('g:no_javascript_maps')
  " these patterns are borrowed and/or expanded from:
  " https://github.com/okcompute/vim-javascript-motions/blob/master/autoload/javascript/motions.vim
  let s:class_pattern = '^\s*\(export\)\=\s*class\s'
  let s:block_pattern = '^\s*[^(]\+(.*)[^{]*{.*$'
  " Pipes need to be double-escaped when passing the pattern into a function in
  " the *noremap defintion
  let s:function_pattern = escape('^\s*\%(\(if\|for\|switch\|while\)\@!.\)*(.*).*{.*$', "|")


  function! <SID>Jump(mode, motion, flags, count, ...) range
      let l:startofline = (a:0 >= 1) ? a:1 : 1

      if a:mode == 'x'
          normal! gv
      endif

      if l:startofline == 1
          normal! 0
      endif

      let cnt = a:count
      mark '
      while cnt > 0
          call search(a:motion, a:flags)
          let cnt = cnt - 1
      endwhile

      if l:startofline == 1
          normal! ^
      endif
  endfun


  execute "nnoremap <silent> <buffer> ][ :<C-U>call <SID>Jump('n', '". s:block_pattern ."', 'W', v:count1)<cr>"
  execute "onoremap <silent> <buffer> ][ :call <SID>Jump('o', '". s:block_pattern ."', 'W', v:count1)<cr>"
  execute "xnoremap <silent> <buffer> ][ :call <SID>Jump('x', '". s:block_pattern ."', 'W', v:count1)<cr>"

  execute "nnoremap <silent> <buffer> [] :<C-U>call <SID>Jump('n', '". s:block_pattern ."', 'Wb', v:count1)<cr>"
  execute "onoremap <silent> <buffer> [] :call <SID>Jump('o', '". s:block_pattern ."', 'Wb', v:count1)<cr>"
  execute "xnoremap <silent> <buffer> [] :call <SID>Jump('x', '". s:block_pattern ."', 'Wb', v:count1)<cr>"

  execute "nnoremap <silent> <buffer> ]] :<C-U>call <SID>Jump('n', '". s:class_pattern ."', 'W', v:count1)<cr>"
  execute "onoremap <silent> <buffer> ]] :call <SID>Jump('o', '". s:class_pattern ."', 'W', v:count1)<cr>"
  execute "xnoremap <silent> <buffer> ]] :call <SID>Jump('x', '". s:class_pattern ."', 'W', v:count1)<cr>"

  execute "nnoremap <silent> <buffer> [[ :<C-U>call <SID>Jump('n', '". s:class_pattern ."', 'Wb', v:count1)<cr>"
  execute "onoremap <silent> <buffer> [[ :call <SID>Jump('o', '". s:class_pattern ."', 'Wb', v:count1)<cr>"
  execute "xnoremap <silent> <buffer> [[ :call <SID>Jump('x', '". s:class_pattern ."', 'Wb', v:count1)<cr>"

  execute "nnoremap <silent> <buffer> ]m :<C-U>call <SID>Jump('n', '". s:function_pattern ."', 'W', v:count1)<cr>"
  execute "onoremap <silent> <buffer> ]m :call <SID>Jump('o', '". s:function_pattern ."', 'W', v:count1)<cr>"
  execute "xnoremap <silent> <buffer> ]m :call <SID>Jump('x', '". s:function_pattern ."', 'W', v:count1)<cr>"

  execute "nnoremap <silent> <buffer> [m :<C-U>call <SID>Jump('n', '". s:function_pattern ."', 'Wb', v:count1)<cr>"
  execute "onoremap <silent> <buffer> [m :call <SID>Jump('o', '". s:function_pattern ."', 'Wb', v:count1)<cr>"
  execute "xnoremap <silent> <buffer> [m :call <SID>Jump('x', '". s:function_pattern ."', 'Wb', v:count1)<cr>"

endif

