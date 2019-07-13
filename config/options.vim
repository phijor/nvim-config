set backup             " keep a backup file (restore to previous version)
set undofile           " keep an undo file (undo changes after closing)
set showcmd            " display incomplete commands
set background=dark    " background color
set number             " show line numbers
set hidden             " hide instead of unload buffers
set ignorecase
set smartcase
set incsearch
set showmatch
set autoindent
set ruler              " show the cursor position all the time
set cursorline         " underline the line the cursor is on
" set relativenumber
set visualbell
set noerrorbells
set history=50         " keep 50 lines of command line history
set undolevels=1000
set textwidth=0
set colorcolumn=81
set tabstop=4
set shiftwidth=0        " use value of tabstop
set softtabstop=-1      " use value of tabstop
set expandtab
set shiftround
set clipboard+=unnamedplus
set backspace=indent,eol,start  " more powerful backspacing
set splitbelow                  " split windows below the current window
set wildmode=list:longest       " set zsh-like command autocomplete
set wildmenu
set fillchars+=vert:█
set cmdheight=2
set signcolumn=yes
set shortmess+=c " don't give |ins-completion-menu| messages.

set updatetime=300

set guicursor=

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg

"Set backup-dir for .*~-files
set bdir-=.
set bdir^=$XDG_CACHE_HOME/nvim/backupfiles/backup//

"Set backup-dir for .*.swp-files
set dir-=.
set dir^=$XDG_CACHE_HOME/nvim/backupfiles/swap//

"Set undo-dir for .*.un~-files
set undodir-=.
set undodir^=$XDG_CACHE_HOME/nvim/backupfiles/undo//

set grepprg=grep\ -nH\ $*
