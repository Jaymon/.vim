execute 'source ' . expand('<sfile>:p:h') . '/javascript.vim'

" method calls (foo.method_call())
syn match typescriptMethodCall "\.\@<=\h\w*(\@=" containedin=typescriptProp

" class creation (new ClassName())
syn match typescriptInstantiation "\%(new\s\+\)\@<=\h\w*" containedin=typescriptIdentifierName

" function calls (foo())
syn match typescriptFunctionCall "\%([\.]\)\@<!\<[a-z_]\w*(\@=" containedin=typescriptIdentifierName

"syn keyword typescriptOperater new nextgroup=typescriptIinstantiation skipwhite


" more hilighting of special comments I tend to use
" http://stackoverflow.com/a/1819151/5006
" http://learnvimscriptthehardway.stevelosh.com/chapters/46.html
" https://vi.stackexchange.com/a/19043
syn keyword typescriptCommentTodo contained DEPRECATED WARNING WARN NOTE
" allow ??? or !!! similar to XCode
syn match typescriptCommentNote "[?!]\{3,\}"
  \ containedin=typescriptLineComment, typescriptComment, typescriptDocComment
hi link typescriptCommentNote typescriptCommentTodo


" 2025-05-01 - I can't get this to work, it will highlight in certain cases but
" not all cases, so I'm abandoning trying to make `async` bold and leaving
" `await` unbolded
"syn match typescriptAsyncFuncDefKeyword "\<async\>" containedin=typescriptAsyncFuncKeyword
"syn keyword typescriptAsyncFuncDefKeyword async containedin=typescriptAsyncFuncKeyword,typescriptParenExp,typescriptBlock
"syn match typescriptAsyncFuncDefKeyword "async" containedin=typescriptAsyncFuncKeyword

"syn keyword typescriptAsyncFuncDefKeyword async containedin=typescriptAsyncFuncKeyword skipwhite
"syn keyword typescriptAsyncFuncDefKeyword async contains=typescriptAsyncFuncKeyword skipwhite
