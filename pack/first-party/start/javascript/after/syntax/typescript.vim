execute 'source ' . expand('<sfile>:p:h') . '/javascript.vim'

" method calls (foo.method_call())
syn match typescriptMethodCall "\.\@<=\h\w*(\@=" containedin=typescriptProp

" class creation (new ClassName())
syn match typescriptInstantiation "\%(new\s\+\)\@<=\h\w*"
    \ containedin=typescriptIdentifierName

" function calls (foo())
syn match typescriptFunctionCall "\%([\.]\)\@<!\<[a-z_]\w*(\@="
    \ containedin=typescriptIdentifierName,typescriptMember


" special comments I tend to use
syn keyword typescriptCommentTodo contained DEPRECATED WARNING WARN NOTE
" allow ??? or !!! similar to XCode
syn match typescriptCommentNote "[?!]\{3,\}"
  \ containedin=typescriptLineComment, typescriptComment, typescriptDocComment
hi link typescriptCommentNote typescriptCommentTodo
hi link typescriptCommentTodo javaScriptCommentTodo


syn match typescriptSemi "[;]" containedin=typescriptBlock
hi link typescriptSemi javaScriptSemi


"syn keyword typescriptTypeOf typeof containedin=typescriptTypeReference
"hi link typescriptTypeOf typescriptTypeQuery

syn clear typescriptTypeReference
syn clear typescriptAliasDeclaration

" when you are expanding variables from a return (eg, `const [one, two]` the
" `one` and `two` have this syntax group)
syn clear typescriptDestructureVariable

" since I cleared typescriptTypeReference things like `this` don't get picked
" up in some contexts, this fixes that
syn keyword typescriptPredefinedMember this containedin=typescriptMember
hi link typescriptPredefinedMember typescriptPredefinedType


hi link typescriptDefaultParam typescriptAssign
hi link typescriptUnion typescriptAssign
hi link typescriptBinaryOp typescriptAssign


""
" Handle `async` being highlighted differently than `await`
""
" I couldn't find another way around just clearing the original ruleset
syn clear typescriptAsyncFuncKeyword

" create a new group for `async` so it can be styled separately
syn keyword typescriptAsyncFuncDefKeyword async containedin=ALL
hi link typescriptAsyncFuncDefKeyword javaScriptAsyncFuncDefKeyword

" restore `await` to the original group
syn keyword typescriptAsyncFuncKeyword await

