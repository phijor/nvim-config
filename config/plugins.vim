call plug#begin(expand('$XDG_CONFIG_HOME/nvim/bundle'))
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }

Plug 'flazz/vim-colorschemes'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" Plug 'https://fedorapeople.org/home/fedora/wwoods/public_git/vim-scripts.git'
" Plug 'roman/golden-ratio'
Plug 'zhaocai/GoldenView.Vim'

Plug 'liuchengxu/vista.vim'

" Plug 'nathanaelkane/vim-indent-guides'

" Misc highlighting/naviagtion
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'Raimondi/delimitMate'
Plug 'wellle/targets.vim'

Plug 'kana/vim-operator-user'

" make
Plug 'neomake/neomake'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

Plug 'nvim-lua/popup.nvim' " dep of: telescope.nvim
Plug 'nvim-lua/plenary.nvim' " dep of: telescope.nvim
Plug 'nvim-telescope/telescope.nvim'

" search using The Silver Searcher -- ag
Plug 'Numkil/ag.nvim'

" GLSL
Plug 'tikhomirov/vim-glsl'

if !exists('g:vscode')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'neoclide/coc-neco'
endif

" C/C++
" Plug 'vim-scripts/c.vim'
Plug 'rhysd/vim-clang-format'

Plug 'm-pilia/vim-ccls'
Plug 'jackguo380/vim-lsp-cxx-highlight'

" Rust
Plug 'rust-lang/rust.vim'

" Python
" - autoformatting
Plug 'python/black', { 'tag': '21.6b0' }
Plug 'stsewd/sphinx.nvim', { 'do': ':UpdateRemotePlugins' }

" Xonsh
Plug 'meatballs/vim-xonsh'

" - semantic highlighting

Plug 'rhysd/vim-grammarous'
" Plug 'vigoux/LanguageTool.nvim'

" Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vim-scripts/csv.vim'
Plug 'chikamichi/mediawiki.vim'
Plug 'jceb/vim-orgmode'

Plug 'fidian/hexmode'

Plug 'PotatoesMaster/i3-vim-syntax'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-lua-ftplugin'

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'mhinz/vim-signify'
Plug 'bling/vim-airline'
Plug 'luochen1990/rainbow'

" Plug 'vim-scripts/SudoEdit.vim'
Plug 'lambdalisue/suda.vim'
Plug 'vim-scripts/ReplaceWithRegister'

Plug 'alisdair/vim-armasm'

Plug 'jvirtanen/vim-octave'

Plug 'parsonsmatt/intero-neovim'

" pass
Plug 'https://sanctum.geek.nz/code/vim-redact-pass.git'

" Plug '~/usr/src/vim-loop-syntax'

Plug 'leanprover/lean.vim'

" discord lol
Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins' }

" Firenvim browser integration
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }

Plug 'lepture/vim-jinja'

" ASCII art
Plug 'gyim/vim-boxdraw'

Plug 'cespare/vim-toml'

call plug#end()
