" VISTA
let g:vista_default_executive = 'coc'

" VIMTEX "
" let g:tex_flavor='latex'
" let g:vimtex_compiler_progname='nvr'
" let g:vimtex_quickfix_enabled=1
" let g:vimtex_fold_enabled=1
" let g:vimtex_view_method='zathura'

" CLANG-FORMAT "
let g:clang_format#auto_formatexpr=1

" PYTHON-BLACK
let g:black_virtualenv = $XDG_CONFIG_HOME . '/nvim/bundle/black/venv'

" GOLDENVIEW "
let g:goldenview__enable_default_mapping = 0

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

" RUST
let g:rustfmt_autosave = 0

"
let g:languagetool_server_command="/usr/bin/languagetool"

" NvimTree
let g:nvim_tree_icons = {
    \ 'default': '•',
    \ 'symlink': '→',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "⥇",
    \   'renamed': "→",
    \   'untracked': "★",
    \   'deleted': "␡",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "▼",
    \   'arrow_closed': "▶",
    \   'default': "🗀",
    \   'open': "🗁",
    \   'empty': "🗀",
    \   'empty_open': "🗁",
    \   'symlink': '→',
    \   'symlink_open': '→',
    \   },
    \   'lsp': {
    \     'hint': "😏",
    \     'info': "ℹ",
    \     'warning': "⚠",
    \     'error': "⛔",
    \   }
    \ }

let g:nvim_tree_icon_padding = '  '

let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 1,
    \ 'files': 0,
    \ 'folder_arrows': 1,
    \ }
