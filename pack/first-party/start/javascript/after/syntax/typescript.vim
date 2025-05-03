execute 'source ' . expand('<sfile>:p:h') . '/javascript.vim'

" method calls (foo.method_call())
syn match typescriptMethodCall "\.\@<=\h\w*(\@=" containedin=typescriptProp

" class creation (new ClassName())
syn match typescriptInstantiation "\%(new\s\+\)\@<=\h\w*" containedin=typescriptIdentifierName

" function calls (foo())
syn match typescriptFunctionCall "\%([\.]\)\@<!\<[a-z_]\w*(\@=" containedin=typescriptIdentifierName


" special comments I tend to use
syn keyword typescriptCommentTodo contained DEPRECATED WARNING WARN NOTE
" allow ??? or !!! similar to XCode
syn match typescriptCommentNote "[?!]\{3,\}"
  \ containedin=typescriptLineComment, typescriptComment, typescriptDocComment
hi link typescriptCommentNote typescriptCommentTodo
hi link typescriptCommentTodo javaScriptCommentTodo


syn match typescriptSemi "[;]" containedin=typescriptBlock
hi link typescriptSemi javaScriptSemi

