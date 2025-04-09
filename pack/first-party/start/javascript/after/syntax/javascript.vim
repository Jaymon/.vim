
" more hilighting of special comments I tend to use
" http://stackoverflow.com/a/1819151/5006
" http://learnvimscriptthehardway.stevelosh.com/chapters/46.html
" https://vi.stackexchange.com/a/19043
syn keyword javaScriptCommentTodo contained DEPRECATED WARNING WARN
" allow ??? or !!! similar to XCode
syn match javaScriptCommentNote "[?!]\{3,\}" containedin=javaScriptLineComment, javaScriptComment
hi link javaScriptCommentNote javaScriptCommentTodo

