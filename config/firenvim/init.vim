runtime config/firenvim/autocommands.vim

let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'content': 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'once',
        \ },
    \ }
\ }

let fc = g:firenvim_config['localSettings']
let fc['https?://[^/]+\.bbb\.zih\.tu-dresden\.de/'] = { 'takeover': 'never', 'priority': 1 }
let fc['https?://[^/]+\.matrix\.tu-dresden\.de/'] = { 'takeover': 'never', 'priority': 1 }
