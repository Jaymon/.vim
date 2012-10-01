" Vim color file
" Maintainer:   Jay Marcyes <jay@marcyes.com>
" Last Change:  8-2-12
" URL:		http://marcyes.com

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

" your pick:
set background=light
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="jaymon"

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

" http://vim.wikia.com/wiki/Highlight_current_line
hi cursorLine guibg=#ECF7FF

hi MatchParen guibg=#FFFF80

if exists('+colorcolumn')
  set colorcolumn=80
  highlight ColorColumn ctermbg=lightgrey guibg=#ECF7FF
endif

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
hi LineNr guifg=#A0A0A0 guibg=#ECF7FF
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

" orange: #FF8000
" red: #FF0000
" light grey: #DEDAE0
" dark blue: #000080

" syntax highlighting groups
hi Comment guifg=#DEDAE0
hi Constant guifg=#FF0000 " string, integer
hi Identifier	guifg=#000080 " method names, .func()
hi Statement  guifg=#FF8000 " if, else, return, def
hi PreProc  guifg=#FF8000 " import statements
hi Type guifg=#0000FF
hi Special  guifg=#A0A0A0
hi Number guifg=#000080
hi Float guifg=#000080
"hi Underlined	
"hi Ignore		
"hi Error		
"hi Todo		

" http://stackoverflow.com/questions/8309815/vim-conceal-with-more-than-one-character
hi conceal ctermfg=DarkBlue ctermbg=NONE guifg=#D4CED4 guibg=NONE
" for highlighting chars like newline and tab
highlight NonText guifg=#D4CED4
highlight SpecialKey guifg=#D4CED4
hi NonReservedKeyword guifg=black ctermfg=black cterm=bold gui=bold

" python specific highlighting
hi pythonFormatStrTemplate guifg=#800000
"hi pythonFormatStrTemplate guifg=#660000
hi pythonStrFormatting guifg=#CC0000
hi pythonStrFormat guifg=#CC0000
