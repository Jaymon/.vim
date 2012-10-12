

syn match pythonFormatStrTemplate	"{[a-zA-Z0-9_]*}" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString

" http://ssiaf.blogspot.com/2009/07/negative-lookbehind-in-vim.html
syn match pythonMethod "\.[a-zA-Z0-9_]*(\@="
syn keyword NonReservedKeyword self cls
syn keyword pythonBuiltinObj	__class__

hi link pythonMethod	Function
hi link pythonFormatStrTemplate Special
hi link NonReservedKeyword Special

" these things annoy me, so remove their highlighting
syn clear PythonError
