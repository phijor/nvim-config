set background=dark
highlight clear
colorscheme vim

if exists('syntax_on')
    syntax reset
endif

let colors_name = "phijor"
set notermguicolors

highlight ExtraWhitespace ctermfg=yellow cterm=undercurl

highlight WinSeparator ctermbg=none ctermfg=black cterm=nocombine
highlight WinBar ctermbg=black ctermfg=white cterm=NONE
highlight WinBarNC ctermbg=black ctermfg=gray cterm=NONE

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
highlight! link String Constant

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
highlight IblWhitespace ctermfg=white cterm=nocombine

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
highlight! link Pmenu Normal
highlight PmenuSel    cterm=underline
highlight PmenuThumb  cterm=reverse
highlight PmenuKind   cterm=italic

" Highlight for completion items (for blink.cmp)
highlight BlinkCmpLabelMatch ctermfg=cyan
highlight BlinkCmpLabelDeprecated cterm=strikethrough

highlight link BlinkCmpKindClass Type
highlight link BlinkCmpKindEnum BlinkCmpKindClass
highlight link BlinkCmpKindStruct BlinkCmpKindClass
highlight link BlinkCmpKindTypeParameter BlinkCmpKindClass

highlight BlinkCmpKindFunction ctermfg=cyan
highlight link BlinkCmpKindMethod BlinkCmpKindFunction

highlight link BlinkCmpKindOperator Operator

highlight link BlinkCmpKindConstant Constant
highlight link BlinkCmpKindConstructor BlinkCmpKindConstant
highlight link BlinkCmpKindEnumMember BlinkCmpKindConstant
highlight link BlinkCmpKindField BlinkCmpKindConstant
highlight link BlinkCmpKindFile BlinkCmpKindConstant
highlight link BlinkCmpKindFolder BlinkCmpKindConstant

highlight link BlinkCmpKindKeyword Keyword
highlight link BlinkCmpKindModule Include
highlight link BlinkCmpKindInterface Include
highlight link BlinkCmpKindVariable Identifier

highlight BlinkCmpKindSnippet cterm=italic ctermfg=darkyellow

" LSP highlights
highlight DiagnosticsError       ctermfg=red
highlight DiagnosticsWarning     ctermfg=yellow
highlight DiagnosticsHint        ctermfg=cyan
highlight DiagnosticsInformation ctermfg=green

highlight DiagnosticsUnderlineError       ctermfg=red    cterm=underline
highlight DiagnosticsUnderlineWarning     ctermfg=yellow cterm=underline
highlight DiagnosticsUnderlineHint        ctermfg=cyan   cterm=underline
highlight DiagnosticsUnderlineInformation ctermfg=green  cterm=underline

highlight DiagnosticVirtualTextError  ctermfg=red    cterm=italic
highlight DiagnosticVirtualTextWarn   ctermfg=yellow cterm=italic
highlight DiagnosticVirtualTextHint   ctermfg=grey   cterm=italic
highlight DiagnosticVirtualTextInfo   ctermfg=white  cterm=italic
highlight DiagnosticVirtualTextOk     ctermfg=green  cterm=italic

" Fixes
highlight link IdrisPragma Special
highlight link IdrisType Type
highlight link IdrisModule Keyword
highlight link IdrisImport Keyword
highlight link IdrisStructure Keyword
highlight link IdrisWhere Keyword
highlight link IdrisVisibility Special

" Rainbow Delimiters
highlight RainbowDelimiterRed     ctermfg=Red
highlight RainbowDelimiterYellow  ctermfg=Yellow
highlight RainbowDelimiterBlue    ctermfg=Blue
highlight RainbowDelimiterOrange  ctermfg=Red
highlight RainbowDelimiterGreen   ctermfg=Green
highlight RainbowDelimiterViolet  ctermfg=Magenta
highlight RainbowDelimiterCyan    ctermfg=Cyan

" Agda (via Cornelis)
highlight CornelisCustomData ctermfg=darkmagenta
highlight link CornelisField        CornelisCustomData
highlight link CornelisConstructor  CornelisCustomData
highlight link CornelisModule       Include

highlight CornelisOperator      ctermfg=darkcyan
highlight CornelisName          ctermfg=gray cterm=bold
highlight CornelisArgument      ctermfg=gray cterm=italic
highlight CornelisBound         ctermfg=lightgray cterm=bold
highlight CornelisSymbol        ctermfg=darkgray
highlight CornelisGeneralizable ctermfg=magenta cterm=italic
highlight CornelisHole          ctermfg=yellow ctermbg=NONE cterm=undercurl
