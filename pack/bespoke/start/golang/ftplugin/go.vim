" turn on go stuff if it is available
if empty($GOROOT) && (!empty($GOPATH) || executable('go'))
  let $GOROOT = fnamemodify(system('which go'), ':p:h:h')
endif
if !empty($GOROOT)
  set rtp+=$GOROOT/misc/vim
endif

