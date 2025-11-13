" Golang syntax file specific to me and my favored color scheme

" special comments I tend to use
syn keyword goScriptCommentTodo contained DEPRECATED WARNING WARN NOTE
hi link goScriptCommentTodo Todo

" allow ??? or !!! similar to XCode
syn match goScriptCommentNote "[?!]\{3,\}" containedin=goComment
hi link goScriptCommentNote Todo


syn keyword NonReservedKeyword self


syn match goMethodCall "\.\@<=[A-Za-z_]\w*(\@="
hi link goMethodCall Function

syn match goFunctionCall "\%([\.]\)\@<!\<[A-Za-z_]\w*(\@="
hi link goFunctionCall Function


syn match goTypeDef "\%(type\s\+\)\@<=\h\w*"
hi link goTypeDef Class

syn match goFunctionDef "\%()\s\+\|^\s*\|^func\s\+\)\@<=\h\w*(\@="
hi link goFunctionDef Function


syn match goMathOperator "[+=:*&%><!^|\-]\+"
hi link goMathOperator Operator


" The `fmt.Sprintf` type formatters (eg, `%v`)
hi link goFormatSpecifier StringTemplate


""
" block statements are the orange keywords in the body of the code
""
" for, while
hi link goStatement blockStatement
hi link goConditional blockStatement
hi link goRepeat blockStatement
hi link goMathOperator blockStatement


""
" Definition statements are orange and bold
""
"hi link pythonAsyncDef defStatement


"syn match goBlockOperator "[{}]"
"hi link goBlockOperator Operator

