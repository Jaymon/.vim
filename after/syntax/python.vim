

syn match pythonFormatStrTemplate	"{[a-zA-Z0-9_]*}" contained containedin=pythonString,pythonUniString,pythonRawString,pythonUniRawString

" http://ssiaf.blogspot.com/2009/07/negative-lookbehind-in-vim.html
syn match pythonMethod "\.[a-zA-Z0-9_]*(\@="

hi link pythonMethod	Function
hi link pythonFormatStrTemplate Special
