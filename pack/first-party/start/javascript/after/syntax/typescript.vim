execute 'source ' . expand('<sfile>:p:h') . '/javascript.vim'

syn match typescriptMethodCall "\.\@<=\h\w*(\@=" containedin=typescriptProp

syn match typescriptInstantiation "\%(new\s\+\)\@<=\h\w*" containedin=typescriptIdentifierName
"syn keyword typescriptOperater new nextgroup=typescriptIinstantiation skipwhite


