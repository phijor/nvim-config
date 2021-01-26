" VIM-PLUG
let g:plug_shallow = 0 " work around --depth not working for https clones

" VISTA
let g:vista_default_executive = 'coc'

" VIMTEX "
let g:tex_flavor='latex'
let g:vimtex_compiler_progname='nvr'
let g:vimtex_quickfix_enabled=1
let g:vimtex_fold_enabled=1
let g:vimtex_view_method='zathura'

" CLANG-FORMAT "
let g:clang_format#auto_formatexpr=1

" PYTHON-BLACK
let g:black_virtualenv = $XDG_CONFIG_HOME . '/nvim/bundle/black/venv'

" CHROMATICA "
let g:chromatica#enable_at_startup = 1
let g:chromatica#highlight_feature_level = 2
let g:chromatica#search_source_args = 1
let g:chromatica#global_args = ['-isystem/usr/lib/clang/10.0.1/include']

" GOLDENVIEW "
let g:goldenview__enable_default_mapping = 0

" AIRLINE "
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#vista#enabled = 0 " https://github.com/liuchengxu/vista.vim/issues/85#issuecomment-665394337
let g:airline_theme = 'ansi16'

" SIGNIFY "
let g:signify_vcs_list = [ 'git' ]
let g:signify_sign_delete = '-'
let g:signify_sign_change = '~'

" SUDA "
let g:suda_smart_edit = 1

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
