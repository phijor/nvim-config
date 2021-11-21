set background=dark
highlight clear
if exists('syntax_on')
    syntax reset
endif

highlight ExtraWhitespace ctermfg=yellow cterm=undercurl
highlight VertSplit ctermbg=none ctermfg=black cterm=bold

highlight Pmenu    ctermfg=black ctermbg=lightgrey
highlight PmenuSel ctermfg=black ctermbg=yellow cterm=bold

" LSP highlights
highlight LspDiagnosticsDefaultError       ctermfg=red
highlight LspDiagnosticsDefaultWarning     ctermfg=yellow
highlight LspDiagnosticsDefaultHint        ctermfg=cyan
highlight LspDiagnosticsDefaultInformation ctermfg=green

highlight LspDiagnosticsUnderlineError       ctermfg=red    cterm=underline
highlight LspDiagnosticsUnderlineWarning     ctermfg=yellow cterm=underline
highlight LspDiagnosticsUnderlineHint        ctermfg=cyan   cterm=underline
highlight LspDiagnosticsUnderlineInformation ctermfg=green  cterm=underline

highlight Error      ctermfg=red      ctermbg=none  cterm=undercurl
highlight Todo                        ctermbg=green cterm=bold
" highlight Comment    ctermfg=green                  cterm=italic
highlight Comment    ctermfg=green
highlight Constant   ctermfg=magenta
highlight Identifier ctermfg=cyan
highlight PreProc    ctermfg=yellow
highlight Special    ctermfg=yellow                 cterm=bold
highlight Delimiter  ctermfg=red
highlight Statement  ctermfg=blue
highlight Type       ctermfg=green

highlight CursorLine                                    cterm=underline,bold
highlight ColorColumn  ctermbg=black
highlight CursorLineNr ctermbg=black    ctermfg=yellow  cterm=bold
highlight LineNr                        ctermfg=white

highlight ErrorMsg     ctermbg=black    ctermfg=red     cterm=bold
highlight Folded       ctermbg=black    ctermfg=white
highlight MatchParen   cterm=reverse

highlight SignColumn    ctermbg=none
highlight Conceal       ctermbg=none    ctermfg=magenta

highlight DiffAdd       ctermbg=none    ctermfg=green   cterm=bold
highlight DiffChange    ctermbg=none    ctermfg=yellow  cterm=bold
highlight DiffDelete    ctermbg=none    ctermfg=red     cterm=bold
highlight DiffText                                      cterm=bold

highlight SpellBad       ctermbg=red    ctermfg=NONE    cterm=bold
highlight SpellCap       ctermbg=12     ctermfg=NONE    cterm=bold
