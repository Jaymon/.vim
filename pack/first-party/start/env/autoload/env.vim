" when env#setup() is placed in your .vimrc, this will setup some environment
" variables that you can then use in your script
"
" variables this script sets:
"   $VIMHOME - will point to your vim home directory, usually ~/.vim on Linux
"   type systems and ~/vimfiles/ on windows
"
"   $VIMTEMP - will point to a temp dir that vim can use, usually /tmp on
"   Linux type systems and some user specific temp dir on windows, and some
"   random folder on MacOS

" don't load the environment more than once
if exists("g:loaded_env")
  finish
endif
let g:loaded_env = 1


" sfile has to be expanded outside of any functions, otherwise it will return
" the wrong filepath, found this out at:
" http://tech.groups.yahoo.com/group/vim/message/51381
" :help filename-modifiers
let s:envdir=expand('<sfile>:p:h:h')


function! env#setup()
  " where the .vim or vimfiles directory is located
  " http://superuser.com/questions/119991/how-do-i-get-vim-home-directory
  if empty($VIMHOME)
    " we find the pack directory since if you have this plugin you have a pack
    " directory, s:envdir was calculated when the script loaded, that's the 
    " folder we will start in. The ; means work backwards until it finds the
    " `pack` directory
    " https://vimdoc.sourceforge.net/htmldoc/eval.html#finddir%28%29
    let l:packdir = finddir("pack", s:envdir . ";")

    " the parent of the pack directory will be the home directory
    let l:vimhome = fnamemodify(l:packdir, ':p:h:h')

    let $VIMHOME=l:vimhome

  endif

  " the temp directory vim should use
  if empty($VIMTEMP)
    if !empty($TEMP)
      let $VIMTEMP = $TEMP

    elseif !empty($TMP)
      let $VIMTEMP = $TMP

    elseif !empty($TMPDIR)
      let $VIMTEMP = $TMPDIR

    else
      let $VIMTEMP = '/tmp'

    endif
  endif

endfunction

