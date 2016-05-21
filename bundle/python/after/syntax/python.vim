syn match pythonFormatStrTemplate	"{[a-zA-Z0-9_]*}" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString

" http://ssiaf.blogspot.com/2009/07/negative-lookbehind-in-vim.html
syn match pythonMethod "\.[a-zA-Z0-9_]*(\@="
syn keyword NonReservedKeyword self cls
syn keyword pythonBuiltinObj	__class__ __builtin__

" I like these (eg, and in is not or) better as the same color as for loops and stuff
hi link pythonOperator Statement

" multi-line strings not assigned to a variable should be treated as comments
syn region pythonDocBlock start=/^\s*\zs'''/ end=+'''+ keepend contains=pythonEscape,pythonEscapeError,pythonDocTest,pythonSpaceError,@Spell,pythonTodo
syn region pythonDocBlock start=/^\s*\zs"""/ end=+"""+ keepend contains=pythonEscape,pythonEscapeError,pythonDocTest2,pythonSpaceError,@Spell,pythonTodo

hi link pythonMethod	Function
hi link pythonFormatStrTemplate Special
hi link NonReservedKeyword Special
hi link pythonDocBlock Comment

" these things annoy me, so remove their highlighting
syn clear PythonError
syn clear PythonNumberError

" more hilighting of special comments I tend to use
" http://stackoverflow.com/a/1819151/5006
" http://learnvimscriptthehardway.stevelosh.com/chapters/46.html
syn keyword pythonTodo DEPRECATED WARNING NOTE WARN
" allow ??? or !!! similar to XCode
syn match pythonNote "[?!]\{3,\}" containedin=PythonComment,pythonDocBlock
hi link pythonNote pythonTodo

