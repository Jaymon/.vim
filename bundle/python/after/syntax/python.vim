" This is Jay's python syntax customization file
"
" cool help screens
" :he syn-keyword
" :he syn-match
"
" http://learnvimscriptthehardway.stevelosh.com/chapters/45.html
" http://learnvimscriptthehardway.stevelosh.com/chapters/46.html

" http://ssiaf.blogspot.com/2009/07/negative-lookbehind-in-vim.html
syn match pythonMethod "\.[a-zA-Z0-9_]*(\@="
syn keyword NonReservedKeyword self cls
syn keyword pythonBuiltinObj __class__ __builtin__ __module__ __dict__ __metaclass__
syn keyword pythonMagicMethod __new__ __init__ __del__ __cmp__ __eq__ __ne__ __lt__ __gt__ __le__ __ge__ __pos__ __neg__ __abs__ __invert__ __round__ __floor__ __ceil__ __trunc__ __add__ __sub__ __mul__ __floordiv__ __div__ __truediv__ __mod__ __divmod__ __pow__ __lshift__ __rshift__ __and__ __or__ __xor__ __radd__ __rsub__ __rmul__ __rfloordiv__ __rtruediv__ __rmod__ __rdivmod__ __rpow__ __rlshift__ __rrshift__ __rand__ __ror__ __rxor__ __iadd__ __isub__ __imul__ __ifloordiv__ __idiv__ __itruediv__ __imod__ __idivmod__ __ipow__ __ilshift__ __irshift__ __iand__ __ior__ __ixor__ __int__ __long__ __float__ __complex__ __oct__ __hex__ __index__ __trunc__ __coerce__ __str__ __repr__ __unicode__ __format__ __hash__ __nonzero__ __dir__ __sizeof__ __getattr__ __setattr__ __delattr__ __getattribute__ __len__ __getitem__ __setitem__ __delitem__ __iter__ __reversed__ __contains__ __missing__ __instancecheck__ __subclasscheck__ __call__ __enter__ __exit__ __get__ __set__ __delete__ __copy__ __deepcopy__ __getinitargs__ __getnewargs__ __getstate__ __setstate__ __reduce__ __reduce_ex__ __bytes__ __bool__ __next__ containedin=pythonFunction,pythonMethod

" why did this not work?
"syn keyword pythonBuiltinObj __class__ __builtin__ __module__ __dict__
"syn keyword pythonMagicMethod __new__ __init__ __del__
"syn keyword pythonMagicMethod __cmp__ __eq__ __ne__ __lt__ __gt__ __le__ __ge__
"syn keyword pythonMagicMethod __pos__ __neg__ __abs__ __invert__ __round__ __floor__ __ceil__ __trunc__
"syn keyword pythonMagicMethod __add__ __sub__ __mul__ __floordiv__ __div__ __truediv__ __mod__
"syn keyword pythonMagicMethod __divmod__ __pow__ __lshift__ __rshift__ __and__ __or__ __xor__
"syn keyword pythonMagicMethod __radd__ __rsub__ __rmul__ __rfloordiv__ __rtruediv__ __rmod__
"syn keyword pythonMagicMethod __rdivmod__ __rpow__ __rlshift__ __rrshift__ __rand__ __ror__ __rxor__
"syn keyword pythonMagicMethod __iadd__ __isub__ __imul__ __ifloordiv__ __idiv__ __itruediv__
"syn keyword pythonMagicMethod __imod__ __idivmod__ __ipow__ __ilshift__ __irshift__ __iand__ __ior__ __ixor__
"syn keyword pythonMagicMethod __int__ __long__ __float__ __complex__ __oct__ __hex__ __index__ __trunc__ __coerce__
"syn keyword pythonMagicMethod __str__ __repr__ __unicode__ __format__ __hash__ __nonzero__
"syn keyword pythonMagicMethod __dir__ __sizeof__ __getattr__ __setattr__ __delattr__ __getattribute__
"syn keyword pythonMagicMethod __len__ __getitem__ __setitem__ __delitem__ __iter__
"syn keyword pythonMagicMethod __reversed__ __contains__ __missing__
"syn keyword pythonMagicMethod __instancecheck__ __subclasscheck__
"syn keyword pythonMagicMethod __call__ __enter__ __exit__
"syn keyword pythonMagicMethod __get__ __set__ __delete__
"syn keyword pythonMagicMethod __copy__ __deepcopy__
"syn keyword pythonMagicMethod __getinitargs__ __getnewargs__ __getstate__ __setstate__ __reduce__ __reduce_ex__
"syn keyword pythonMagicMethod __bytes__ __bool__
"syn keyword pythonMagicMethod containedin=PythonFunction

" I like these (eg, and in is not or) better as the same color as for loops and stuff
hi link pythonOperator Statement


" multi-line strings not assigned to a variable should be treated as comments
" the \zs in the regex means start the matching right before the next match (so it
" will highlight the starting triple quotes and ignore the matching whitespace)
syn region pythonDocBlock start=+^\s*\zs'''+ skip=+\\'+ end=+'''+ contains=pythonDocTest,pythonSpaceError,@Spell,pythonTodo
syn region pythonDocBlock start=+^\s*\zs"""+ skip=+\\"+ end=+"""+ contains=pythonDocTest,pythonSpaceError,@Spell,pythonTodo

hi link pythonMethod Function
hi link pythonMagicMethod pythonMethod
hi link pythonFormatStrTemplate Special
hi link NonReservedKeyword Special
hi link pythonDocBlock Comment
hi link pythonBuiltinObj Structure
hi link PythonClassVar NonReservedKeyword

" more hilighting of special comments I tend to use
" http://stackoverflow.com/a/1819151/5006
" http://learnvimscriptthehardway.stevelosh.com/chapters/46.html
syn keyword pythonTodo DEPRECATED WARNING NOTE WARN
" allow ??? or !!! similar to XCode
syn match pythonNote "[?!]\{3,\}" containedin=PythonComment,pythonDocBlock
hi link pythonNote pythonTodo

