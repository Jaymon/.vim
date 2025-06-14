"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim color file
" Maintainer: Jay Marcyes <jay@marcyes.com>
" Since: 8-2-12
"
" cool help screens:
" * :he highlight
" * :he group-name
" * :he highlight-groups
" * :he cterm-colors
"
" Current colors:
"
" * #FF8000 - orange (import)
" * #AF00DB - purple (class names)
" * #800000 - darker red for highlights in strings
" * #0000FF - blue, method names and method calls
" * #F3FAFF - light blue highlight background of linenumbers and highlight line
"
" a list of the 256 available colors
" http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
" http://www.vim.org/scripts/script.php?script_id=3412
"
" It doesn't look like you can set colors in a variable without a bit of hassle
"   https://vi.stackexchange.com/questions/10020/how-to-use-a-variable-value-in-a-colorscheme
"
"   You can reload the color scheme in any file by running:
"
"     :source $VIMHOME/colors/jaymon_light.vim
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=light
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="jaymon_light"

"hi Normal

" OR

" highlight clear Normal
" set background&
" highlight clear
" if &background == "light"
"   highlight Error ...
"   ...
" else
"   highlight Error ...
"   ...
" endif

" A good way to see what your colorscheme does is to follow this procedure:
" :w 
" :so % 
"
" Then to see what the current setting is use the highlight command.  
" For example,
" 	:hi Cursor
" gives
"	Cursor         xxx guifg=bg guibg=fg 
 	
" Uncomment and complete the commands you want to change from the default.
"hi Cursor		
"hi CursorIM	
"hi Directory	
"hi DiffAdd		
"hi DiffChange	
"hi DiffDelete	
"hi DiffText	
"hi ErrorMsg	
"hi VertSplit	
"hi Folded		
"hi FoldColumn	
"hi IncSearch	
"hi ModeMsg		
"hi MoreMsg		
"hi NonText		
"hi Question	
"hi Search		
"hi SpecialKey	
"hi StatusLine	
"hi StatusLineNC	
"hi Title		
"hi Visual		
"hi VisualNOS	
"hi WarningMsg	
"hi WildMenu	
"hi Menu		
"hi Scrollbar	
"hi Tooltip		
"hi Underlined	
"hi Ignore		
"hi Error		
"hi Todo		

" orange: #FF8000
" red: #FF0000
" light grey: #DEDAE0
" dark blue: #000080


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Presets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi blockStatement guifg=#FF8000 ctermfg=magenta cterm=none gui=none 
hi defStatement guifg=#FF8000 ctermfg=magenta cterm=bold gui=bold


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" background highlight color
"
" Previous color was: #ECF7FF (changed 12-3-2024)
"   https://www.color-hex.com/color/ecf7ff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" http://vim.wikia.com/wiki/Highlight_current_line
hi cursorLine guibg=#F3FAFF cterm=None term=None

hi ColorColumn ctermbg=None guibg=#F3FAFF

" this was previously in the status line section of my gvimrc, I have no idea
" what it highlights
hi User1 guibg=#F3FAFF guifg=#A0A0A0

" style unhighlighted line numbers
hi LineNr guifg=#BCBCBC guibg=#F3FAFF
" style highlighted line number
" https://stackoverflow.com/questions/8247243/highlighting-the-current-line-number-in-vim
hi CursorLineNr guifg=#838383
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


hi MatchParen guibg=#FFFF80 ctermbg=yellow

" syntax highlighting groups
hi Comment guifg=#DEDAE0 ctermfg=lightgrey
hi Constant guifg=#000000 cterm=bold gui=bold
" python: method names, .func()
" hi Identifier	guifg=#000080 
hi Identifier guifg=#0000FF ctermfg=blue

" python: for and or in
"hi Operator	guifg=#000080 ctermfg=darkblue
hi Operator	guifg=#FF8000 cterm=bold gui=bold

" python: if, else, return, def
hi Statement guifg=#FF8000 
"hi Statement guifg=#FF8000 cterm=bold gui=bold  
"hi Statement guifg=#000000 cterm=bold gui=bold  
" python: import statements
hi PreProc guifg=#FF8000 
" hi Type guifg=#0000FF
hi Type guifg=#000000 cterm=bold gui=bold  
hi Special guifg=#A0A0A0

"hi Number guifg=#000080 ctermfg=darkblue
hi Number guifg=#267f99

hi Float guifg=#000080 ctermfg=darkblue
hi String guifg=#FF0000 ctermfg=red

hi Structure ctermfg=black cterm=bold guifg=black gui=bold

" completely ignore error highlighting, individual syntax files can turn it on
" but I absolutely hate it
" https://superuser.com/a/654947
hi Error NONE
hi ErrorMsg NONE

" http://stackoverflow.com/questions/8309815/vim-conceal-with-more-than-one-character
hi conceal ctermfg=DarkBlue ctermbg=NONE guifg=#D4CED4 guibg=NONE
" for highlighting chars like newline and tab
highlight NonText guifg=#b9e2ff
highlight SpecialKey guifg=#b9e2ff

hi NonReservedKeyword guifg=black ctermfg=black cterm=bold gui=bold

" Customize the popup window that can appear when running jobs
hi MessageWindow guifg=#BCBCBC guibg=#F3FAFF


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimscript specific highlighting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For some reason strings in a comment are highlighted like normal strings
hi link VimCommentString VimLineComment

" make titles in comments (eg `" Foo:`) just a darker shade of gray
hi VimCommentTitle term=bold ctermfg=5 guifg=#A0A0A0
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python specific highlighting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi pythonFormatStrTemplate guifg=#800000 ctermfg=magenta
hi pythonBytesEscape guifg=#800000 ctermfg=magenta
"hi pythonFormatStrTemplate guifg=#660000
hi pythonStrFormatting guifg=#CC0000 ctermfg=magenta
hi pythonStrFormat guifg=#CC0000 ctermfg=magenta
hi pythonMagicMethod guifg=#0000FF ctermfg=blue cterm=bold gui=bold
hi pythonMathOperator guifg=#AF00DB
hi pythonClass guifg=#AF00DB ctermfg=DarkMagenta
hi pythonDotNotation guifg=#AF00DB

""
" block statements are the orange keywords in the body of the code
""
" for, while
hi link pythonRepeat blockStatement
hi link pythonOperator blockStatement
hi link pythonAsync blockStatement
hi link pythonReturnStatement blockStatement
hi link pythonException blockStatement
hi link pythonConditional blockStatement
hi link pythonStatementOperator blockStatement
hi link pythonStatement blockStatement
hi link pythonDecorator blockStatement

""
" Definition statements are orange and bold
""
hi link pythonAsyncDef defStatement
hi link pythonInclude defStatement
hi link pythonIncludeFrom defStatement
hi link pythonDefStatement defStatement


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown specific highlighting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight markdownH1 ctermfg=5 guifg=#FF00AF
highlight markdownH2 ctermfg=4 guifg=#FF00D7
highlight markdownH3 ctermfg=13 guifg=#FF00FF
highlight markdownH4 ctermfg=12 guifg=#FF0087
highlight markdownH5 ctermfg=163 guifg=#FF005F
highlight markdownH6 ctermfg=56 guifg=#FF5FFF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Ruby specific highlighting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi rubyStringDelimiter guifg=#CC0000 ctermfg=magenta
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" javascript/typescript specific highlighting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
hi typescriptExport guifg=#FF8000 ctermfg=magenta cterm=bold gui=bold
hi typescriptImport guifg=#FF8000 ctermfg=magenta cterm=bold gui=bold
hi typescriptImportType guifg=#FF8000 ctermfg=magenta cterm=bold gui=bold

" dict keys without quotes
hi typescriptObjectLabel guifg=#800000 ctermfg=magenta cterm=none gui=none

" Make `console.log` look like any other method call
hi link typescriptConsoleMethod Identifier

" Methods like .bind should also look like any other method call
hi link typescriptFunctionMethod Identifier

" .replace
hi link typescriptBOMLocationMethod Identifier

" .push method
hi link typescriptBOMNavigatorProp typescriptProp

" .type method
hi link typescriptDOMEventProp typescriptProp

" .parent
hi link typescriptBOMWindowProp typescriptProp

" .attributes
hi link typescriptDOMNodeProp typescriptProp

" I'm not sure why this set of syntax groups exists in the runtime typescript
" $VIMRUNTIME/syntax/shared/typescriptcommon.vim
hi link typescriptPaymentShippingOptionProp typescriptProp

" .target
hi link typescriptDOMFormProp typesecriptProp

" method calls (eg, 'bar` would be highlighted in `foo.bar()`)
hi link typescriptMethodCall Identifier
hi link typescriptFunctionCall typescriptMethodCall
" .hasOwnProperty method
hi link typescriptObjectMethod typescriptMethodCall
" .getPrototypeOf
hi link typescriptObjectStaticMethod typescriptMethodCall

" .stopPropagation
hi link typescriptDOMEventMethod typescriptMethodCall

" arguments in definitions, calls, and classes
hi typescriptCall guifg=black ctermfg=black
hi typescriptFuncCallArg guifg=black ctermfg=black
hi typescriptFuncComma guifg=black ctermfg=black

""
" Properties should just be black
""
" members in a class definition
hi typescriptMember guifg=black ctermfg=black
hi link typescriptURLUtilsProp typescriptMember

" class definitions
hi typescriptClassName guifg=#AF00DB ctermfg=DarkMagenta
hi link typescriptClassHeritage typescriptClassName
hi typescriptInstantiation guifg=#AF00DB ctermfg=DarkMagenta

" operators: =
hi typescriptDefaultParam guifg=#AF00DB
hi typescriptAssign guifg=#AF00DB
" =>
hi typescriptArrowFunc guifg=#AF00DB ctermfg=magenta cterm=none gui=none

" declare
hi typescriptAmbientDeclaration guifg=#FF8000 ctermfg=magenta cterm=bold gui=bold

" dot between instance and property (eg, the dot after foo in foo.bar)
"hi typescriptDotNotation guifg=#AF00DB
"hi typescriptDotNotation guifg=black ctermfg=black

" let, const
hi typescriptVariable guifg=#FF8000

" Regexes
hi typescriptRegexpString guifg=#FF0000 ctermfg=red
hi link typescriptRegexpCharClass typescriptRegexpString
hi link typescriptRegexpBoundary typescriptRegexpString
hi link typescriptRegexpBackRef typescriptRegexpString
hi link typescriptRegexpQuantifier typescriptRegexpString
hi link typescriptRegexpOr typescriptRegexpString
hi link typescriptRegexpMod typescriptRegexpString
hi link typescriptRegexpGroup typescriptRegexpString


hi javaScriptSemi guifg=#AF00DB

""
" Block keywords/statements
""
hi link typescriptRepeat blockStatement
hi link typescriptStatementKeyword blockStatement
hi link typescriptConditional blockStatement

" `as`
hi link typescriptCastKeyword blockStatement

" `in` in a for statement
hi link typescriptForOperator blockStatement

" instanceof, `in` in an if statement
hi link typescriptKeywordOp blockStatement

" typeof, new
hi link typescriptOperator blockStatement

" keyof
hi link typescriptTypeQuery blockStatement

hi link typescriptAsyncFuncKeyword blockStatement


""
" definition keywords/statements
""
hi link javaScriptAsyncFuncDefKeyword defStatement


"hi typescriptTypeReference guifg=black ctermfg=black 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

