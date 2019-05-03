call plug#begin(expand('$XDG_CONFIG_HOME/nvim/bundle'))
Plug 'Shougo/vimproc.vim', { 'do' : 'make' }

Plug 'flazz/vim-colorschemes'

" Plug 'https://fedorapeople.org/home/fedora/wwoods/public_git/vim-scripts.git'
" Plug 'roman/golden-ratio'
Plug 'zhaocai/GoldenView.Vim'

" Plug 'nathanaelkane/vim-indent-guides'

" Misc highlighting/naviagtion
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'Raimondi/delimitMate'
Plug 'machakann/vim-highlightedyank'
Plug 'wellle/targets.vim'

Plug 'kana/vim-operator-user'

" make
Plug 'neomake/neomake'

" search using The Silver Searcher -- ag
Plug 'Numkil/ag.nvim'

" GLSL
Plug 'tikhomirov/vim-glsl'

" C/C++
Plug 'vim-scripts/c.vim'
Plug 'rhysd/vim-clang-format'

Plug 'Valloric/YouCompleteMe', {
            \   'do': 'python2 install.py --clang-completer --rust-completer --system-libclang --system-boost',
            \   'for': [ 'c', 'cpp', 'haskell', 'python', 'tex', 'rust' ],
            \}
Plug 'rdnetto/YCM-Generator', { 'branch': 'develop' }
Plug 'arakashic/chromatica.nvim', {
            \   'do': ':UpdateRemotePlugins',
            \}
" Rust
Plug 'rust-lang/rust.vim'

" Python
" - autoformatting
Plug 'mindriot101/vim-yapf'
" - semantic highlighting
Plug 'numirias/semshi', {
            \   'do': ':UpdateRemotePlugins',
            \}

Plug 'rhysd/vim-grammarous'

Plug 'lervag/vimtex'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vim-scripts/csv.vim'
Plug 'chikamichi/mediawiki.vim'
Plug 'jceb/vim-orgmode'

Plug 'fidian/hexmode'

Plug 'PotatoesMaster/i3-vim-syntax'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-lua-ftplugin'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
Plug 'bling/vim-airline'
Plug 'luochen1990/rainbow'

" Plug 'vim-scripts/SudoEdit.vim'
Plug 'lambdalisue/suda.vim'
Plug 'vim-scripts/ReplaceWithRegister'

Plug 'alisdair/vim-armasm'

Plug 'jvirtanen/vim-octave'

" Plug 'raichoo/haskell-vim'
" Plug 'lukerandall/haskellmode-vim'
" Plug 'eagletmt/neco-ghc'
Plug 'parsonsmatt/intero-neovim'
" Plug 'enomsg/vim-haskellConcealPlus'

" pass
Plug 'https://sanctum.geek.nz/code/vim-redact-pass.git'

call plug#end()
