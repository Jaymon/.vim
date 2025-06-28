" Vim syntax file
" Language:         Python
" Maintainer:	    Jay Marcyes <vim@marcyes.com>
"
" This is Jay's python syntax customization file
"
" cool help screens
" :he syn-keyword
" :he syn-match
"
" http://learnvimscriptthehardway.stevelosh.com/chapters/45.html
" http://learnvimscriptthehardway.stevelosh.com/chapters/46.html
" https://learnbyexample.gitbooks.io/vim-reference/content/Regular_Expressions.html
"
" This is meant to customize the builtin python syntax file found at:
"
"    /Applications/MacVim.app/Contents/Resources/vim/runtime/syntax/python.vim
"
"
" * \zs - start the matching right before the next match
" * \ze - stop the match right before the next match
" * \@<= - positiver look behind
" * \@<! - negative look behind
" * \@= - positive look ahead
" * \< \> - word boundaries
" * \%( \) - non-recording grouping
" * \= - matches 0 or 1 more of the preceding characters
"
" http://ssiaf.blogspot.com/2009/07/negative-lookbehind-in-vim.html
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Single out python class definitions so they can be highlighted differently
" than python functions
syn match pythonClass "\<_\{-}[A-Z]\w*\>"
syn match pythonClassDef "\%(class\s\+\)\@<=\h\w*"
hi link pythonClassDef pythonClass
syn keyword pythonDefStatement class nextgroup=pythonClassDef skipwhite

syn match pythonMethodCall "\.\@<=[a-z_]\w*(\@="
syn keyword pythonDefStatement def nextgroup=pythonFunction skipwhite

" A function call is a method call that doesn't start with `def `, a period.
" Basically, it has to be proceeded by the start of the file, a whitespace, or
" a non-alphanum character. The call must end with a left paren
syn match pythonFunctionCall "\%(def\s\+\|[\.]\)\@<!\<[a-z_]\w*(\@="


syn keyword NonReservedKeyword self cls
syn keyword pythonBuiltinObj __class__ __builtin__ __module__ __dict__ __metaclass__
    \ __file__ __name__ __qualname__

" https://docs.python.org/3/reference/datamodel.html#special-method-names
syn keyword pythonMagicMethod __new__ __init__ __del__
    \ __cmp__ __eq__ __ne__ __lt__ __gt__ __le__ __ge__
    \ __pos__ __neg__ __abs__ __invert__ __round__ __floor__ __ceil__ __trunc__
    \ __add__ __sub__ __mul__ __floordiv__ __div__  __truediv__ __mod__ __divmod__
    \ __pow__ __lshift__ __rshift__ __and__ __or__ __xor__
    \ __radd__ __rsub__ __rmul__ __rfloordiv__ __rtruediv__ __rmod__ __rdivmod__
    \ __rpow__ __rlshift__ __rrshift__ __rand__ __ror__ __rxor__
    \ __iadd__ __isub__ __imul__ __ifloordiv__ __idiv__ __itruediv__ __imod__ __idivmod__
    \ __ipow__ __ilshift__ __irshift__ __iand__ __ior__ __ixor__
    \ __int__ __long__ __float__ __complex__ __oct__ __hex__ __bool__
    \ __index__ __trunc__ __coerce__ __hash__ __nonzero__
    \ __str__ __bytes__ __repr__ __unicode__ __format__ 
    \ __dir__ __sizeof__ __len__ __length_hint__ __contains__
    \ __iter__ __next__ __reversed__
    \ __aiter__ __anext__
    \ __getattr__ __setattr__ __delattr__ __getattribute__
    \ __getitem__ __class_getitem__ __setitem__ __delitem__ __missing__
    \ __instancecheck__ __subclasscheck__
    \ __call__ __enter__ __exit__
    \ __aenter__ __aexit__
    \ __get__ __set__ __delete__ __objclass__
    \ __copy__ __deepcopy__
    \ __getinitargs__ __getnewargs__ __getstate__ __setstate__
    \ __reduce__ __reduce_ex__
    \ __set_name__ __init_subclass__
    \ __mro_entries__ __prepare__ __mro__ __bases__
    \ __await__
    \ __buffer__ __release_buffer__
    \ __match_args__
    \ __self__ __func__ __wrapped__ __annotations__
    \ containedin=pythonFunction,pythonMethod


" 1-6-2023 - crazy that the default python syntax file doesn't support format strings
syn region pythonFormatString matchgroup=pythonQuotes start=+[fF]\=[rR]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"
syn region pythonFormatString matchgroup=pythonQuotes start=+[rR]\=[fF]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"

" 1-26-2023 - even crazier it doesn't support byte strings
syn region pythonByteString matchgroup=pythonQuotes start=+[bB]\z(['"]\)+ end="\z1" skip="\\\\\|\\\z1"

" 1-6-2023 - matches {...} inside a string (as long as the first { isn't preceded by {
syn match pythonFormatStrTemplate "{\@<!{[^}{]*}" contained containedin=pythonString,pythonRawString,pythonFormatString
hi link pythonFormatStrTemplate Special

" multi-line strings not assigned to a variable should be treated as comments
" Updated 8-5-2024, I added support for r-string docblocks but that means this
" needs to be below pythonFormatStrings because otherwise those will take
" precedence over the docblock
syn region pythonDocBlock start=+^\s*\zs[rR]\?\z('''\|"""\)+ end="\z1" keepend contains=pythonDocTest,pythonSpaceError,@Spell,pythonTodo
hi link pythonDocBlock Comment

""
" Python docblock highlighting
""
" match docblock tags (eg, `:param ...:`) in python docblocks
" I really liked this highlighting on javascript code and so I've copied it for
" python
syn match pythonDocTag "^\s*:\zs[^ :]*" containedin=pythonDocBlock
hi link pythonDocTag Special

" match docblock directives (eg, `.. directive::`) in python docblocks
syn match pythonDocDirective "^\s*\.\.\s\zs[^:]*\ze::" containedin=pythonDocBlock
hi link pythonDocDirective Special


" 3-17-2023 - highlight operators
syn match pythonMathOperator "[+=*/%><!^|\-]\+"
syn match pythonStatementOperator "[:]"


" more hilighting of special comments I tend to use
" http://stackoverflow.com/a/1819151/5006
" http://learnvimscriptthehardway.stevelosh.com/chapters/46.html
syn keyword pythonTodo contained DEPRECATED WARNING WARN
" allow ??? or !!! similar to XCode
syn match pythonNote "[?!]\{3,\}" containedin=PythonComment,pythonDocBlock
hi link pythonNote pythonTodo


" I like these (eg, and in is not or) better as the same color as for loops and stuff
hi link pythonMathOperator Operator
hi link pythonStatementOperator Operator

hi link pythonMethodCall Function
hi link pythonFunctionCall Function
hi link pythonMagicMethod pythonMethod
hi link NonReservedKeyword Special
hi link pythonBuiltinObj Structure
hi link pythonBuiltin Structure
hi link PythonClassVar NonReservedKeyword

hi link pythonFormatString String
hi link pythonByteString String


""
" Many of these are re-definitions from the builtin python file
""
syn clear pythonAsync
syn keyword pythonAsync await
syn match pythonAsyncDef "async\ze\s\+def"
syn match pythonBlockAsync "async\ze\s\+\%(with\|for\)"
hi link pythonBlockAsync pythonAsync
"syn match pythonAsyncDef "async\%(\s\+def\)\@<="
"syn match pythonBlockAsync "async\%(\s\+def\)\@<!"
syn keyword pythonReturnStatement return
syn keyword pythonRepeat pass continue

""
" `from` when used in imports should separte from its use everywhere else
""
syn clear pythonInclude
"syn match pythonIncludeFrom "^\s*\zsfrom\ze\s"
"syn match pythonIncludeFrom "^from\>"
syn keyword pythonInclude import

" regular from in block statements should be treated like other statements
"syn match pythonBlockFrom "\%(\S\|yield\)\s*\zsfrom\ze\s"
"syn match pythonBlockFrom "\s\zsfrom\ze\s"
"syn match pythonBlockFrom "\<from\>"
syn keyword pythonBlockFrom from
hi link pythonBlockFrom pythonStatement


""
" Clear the python decorator so default syntax highlighting applies to
" decorators also. Then redefine the at-symbol since clearing the decorator
" name also nullifies pythonDecorator because it is "contained"
syn clear pythonDecoratorName
syn match pythonDecorator "^\s*\zs@"

