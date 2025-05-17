
" special comments I tend to use
syn keyword javaScriptCommentTodo contained DEPRECATED WARNING WARN NOTE
" allow ??? or !!! similar to XCode
syn match javaScriptCommentNote "[?!]\{3,\}" containedin=javaScriptLineComment, javaScriptComment
hi link javaScriptCommentNote javaScriptCommentTodo
hi link javaScriptCommentTodo Todo


" Match semi-colons
syn match javaScriptSemi "[;]"

syn keyword javaScriptAsyncFuncDefKeyword async containedin=ALL

