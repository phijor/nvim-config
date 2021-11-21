set nobackup           " do not keep a backup file
set nowritebackup
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
set fillchars+=vert:┃
set cmdheight=2
set shortmess+=c " don't give |ins-completion-menu| messages.

set updatetime=300

" set guicursor= " disable changing cursor shape
set guifont=Foo
set title

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg,.egg-info
set wildignore+=.egg-info

"Set backup-dir for .*.swp-files
set directory-=.
set directory-=$XDG_DATA_HOME/nvim/swap//
set directory+=$XDG_RUNTIME_DIR/nvim/swap//

set grepprg=grep\ -nH\ $*

set pyxversion=3

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=1 " start with one level of folds opened
