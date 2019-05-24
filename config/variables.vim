" VIM-PLUG
let g:plug_shallow = 0 " work around --depth not working for https clones

" VIMTEX "
let g:tex_flavor='latex'
let g:vimtex_compiler_progname='nvr'
let g:vimtex_quickfix_enabled=1
let g:vimtex_fold_enabled=1
let g:vimtex_view_method='zathura'

" YOUCOMPLETEME "
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.haskell = [
            \ '.',
            \ 're!import\s+',
\ ]
let g:ycm_semantic_triggers.tex = [
            \ 're!\\[A-Za-z]*(ref|cite)[A-Za-z]*([^]]*])?{([^}]*, ?)*'
\ ]
let g:ycm_confirm_extra_conf = 0
let g:ycm_extra_conf_globlist = [ '!~/usr/src/3ds/other/*', '~/usr/src/3ds/*' ]

" PYTHON-BLACK
let g:black_virtualenv = $XDG_CONFIG_HOME . '/nvim/bundle/black/venv'

" CHROMATICA "
let g:chromatica#enable_at_startup = 1
let g:chromatica#highlight_feature_level = 2
let g:chromatica#search_source_args = 1
let g:chromatica#global_args = ['-isystem/usr/lib/clang/8.0.0/include']

" GOLDENVIEW "
let g:goldenview__enable_default_mapping = 0

" AIRLINE "
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'ansi16'

" SIGNIFY "
let g:signify_vcs_list = [ 'git' ]
let g:signify_sign_delete = '-'
let g:signify_sign_change = '~'

" RAINBOW "
let g:rainbow_active = 1
let g:rainbow_conf = {
\   'ctermfgs': ['lightyellow', 'lightgreen', 'lightblue', 'lightcyan', 'lightmagenta'],
\   'operators': '_,_',
\   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
\   'separately': {
\       '*': {},
\       'c': {
\           'paretheses': [
\               'start=/(/ end=/)/ fold',
\               'start=/\[/ end=/\]/ fold',
\           ],
\       },
\       'tex': {
\           'parentheses': [
\               'start=/(/ end=/)/',
\               'start=/\[/ end=/\]/',
\               'start=/{/ end=/}/',
\           ],
\       },
\       'vim': {
\           'parentheses': [
\               'start=/(/ end=/)/',
\               'start=/\[/ end=/\]/',
\               'start=/{/ end=/}/ fold',
\               'start=/(/ end=/)/ containedin=vimFuncBody',
\               'start=/\[/ end=/\]/ containedin=vimFuncBody',
\               'start=/{/ end=/}/ fold containedin=vimFuncBody'
\           ],
\       },
\       'css': 0,
\       'cmake': 0,
\   }
\}

let g:haddock_browser = 'chromium'

" let hscoptions = "xhl"

" RUST
let g:rustfmt_autosave = 1
