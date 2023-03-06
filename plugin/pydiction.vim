"##############################################################################
" configure pydiction
" https://github.com/rkulla/pydiction
"
" This should load before pack/third-party/opt/pydiction, you can verify this
" by running `:scriptnames` and verifying the order
"
" currently (March 2023) this plugin is in pack/third-party/opt, which means it
" doesn't load by default, so to use crtlp you will need to source it:
"
"   :packadd pydiction
"##############################################################################

let g:pydiction_location = $VIMHOME . '/bundle/pydiction/complete-dict'

