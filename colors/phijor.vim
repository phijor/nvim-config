set background=dark
highlight clear

if exists('syntax_on')
    syntax reset
endif

let colors_name = "phijor"

highlight ExtraWhitespace ctermfg=yellow cterm=undercurl

highlight VertSplit ctermbg=none ctermfg=black cterm=nocombine
highlight StatusLine ctermbg=black ctermfg=white cterm=NONE
highlight StatusLineNC ctermbg=black ctermfg=gray cterm=NONE

" Default highlight groups
highlight Error      ctermfg=red      ctermbg=none  cterm=undercurl
highlight Todo                        ctermbg=green cterm=bold
highlight Comment    ctermfg=lightgreen
highlight Constant   ctermfg=darkmagenta
highlight Identifier ctermfg=cyan                       cterm=none
highlight Function   ctermfg=blue
highlight PreProc    ctermfg=darkyellow
highlight Include    ctermfg=darkyellow
highlight Special    ctermfg=yellow
highlight Delimiter  ctermfg=darkred
highlight Keyword    ctermfg=darkgray                   cterm=none
highlight Statement  ctermfg=darkcyan                   cterm=bold
highlight Operator   ctermfg=blue
highlight Type       ctermfg=darkgreen

highlight default CursorLines ctermbg=black cterm=NONE
highlight! link   CursorLine   CursorLines
highlight! link   CursorColumn CursorLines
highlight CursorLineNr ctermbg=black    ctermfg=yellow  cterm=bold
highlight LineNr                        ctermfg=white
highlight Visual       ctermbg=darkgray                 cterm=bold

highlight ErrorMsg     ctermbg=none    ctermfg=red     cterm=bold
highlight Folded       ctermbg=none    ctermfg=white   cterm=italic
" highlight MatchParen   ctermbg=none    ctermfg=none    cterm=italic,bold
highlight MatchParen   ctermbg=none    ctermfg=none    cterm=italic,underline

" Indent guides
highlight IndentBlankLine ctermfg=white cterm=nocombine

" Fold indicator columns
highlight FoldColumn    ctermbg=none    ctermfg=White

" Sign columns
highlight SignColumn    ctermbg=none
highlight Conceal       ctermbg=none    ctermfg=magenta

" Git diffs
highlight DiffAdd       ctermbg=none    ctermfg=green   cterm=bold
highlight DiffChange    ctermbg=none    ctermfg=yellow  cterm=bold
highlight DiffDelete    ctermbg=none    ctermfg=red     cterm=bold
highlight DiffText                                      cterm=bold

" Spelling
highlight SpellBad      ctermbg=none                    cterm=bold,underline
highlight SpellCap      ctermbg=none                    cterm=bold,underline

" Completion menu
highlight Pmenu    ctermfg=none ctermbg=black
highlight PmenuSel cterm=bold,reverse

" Highlight for completion items (from nvim-cmp)
highlight CmpItemAbbrMatch ctermfg=cyan
highlight link CmpItemAbbrMatchFuzzy CmpItemMatch
highlight CmpItemAbbrDeprecated cterm=strikethrough

highlight CmpItemKind cterm=italic

highlight link CmpItemKindClass Type
highlight link CmpItemKindEnum CmpItemKindClass
highlight link CmpItemKindStruct CmpItemKindClass

highlight CmpItemKindFunction ctermfg=cyan
highlight link CmpItemKindKeyword Keyword

highlight link CmpItemKindModule Include
highlight link CmpItemKindVariable Identifier

" LSP highlights
highlight DiagnosticsError       ctermfg=red
highlight DiagnosticsWarning     ctermfg=yellow
highlight DiagnosticsHint        ctermfg=cyan
highlight DiagnosticsInformation ctermfg=green

highlight DiagnosticsUnderlineError       ctermfg=red    cterm=underline
highlight DiagnosticsUnderlineWarning     ctermfg=yellow cterm=underline
highlight DiagnosticsUnderlineHint        ctermfg=cyan   cterm=underline
highlight DiagnosticsUnderlineInformation ctermfg=green  cterm=underline

" nvim-notify
highlight link NotifyINFOBorder  DiagnosticsInformation
highlight link NotifyDEBUGBorder DiagnosticsHint
highlight link NotifyWARNBorder  DiagnosticsWarning
highlight link NotifyERRORBorder DiagnosticsError

" Fixes
highlight link IdrisPragma Special
highlight link IdrisType Type
highlight link IdrisModule Keyword
highlight link IdrisImport Keyword
highlight link IdrisStructure Keyword
highlight link IdrisWhere Keyword
highlight link IdrisVisibility Special

highlight link CornelisFunction Identifier
highlight CornelisArgument  ctermfg=gray cterm=italic,bold
highlight CornelisSymbol    ctermfg=gray
highlight CornelisInductiveConstructor  ctermfg=darkmagenta
highlight CornelisPrimitive ctermfg=darkyellow cterm=italic
highlight link CornelisPostulate        Special
highlight link CornelisField            CornelisInductiveConstructor
highlight link CornelisBound            Normal
highlight link CornelisGeneralizable    Constant
highlight link CornelisModule           Include
highlight link CornelisFallback         CornelisErrorWarning
highlight CornelisErrorWarning ctermfg=red cterm=undercurl
highlight CornelisHole ctermfg=yellow ctermbg=NONE cterm=undercurl

