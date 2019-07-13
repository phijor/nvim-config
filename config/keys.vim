" custom mappings
" let <Leader> be semicolon because '\' is just to far away
let mapleader = ';'
let maplocalleader = ';'

" map colon to space to save time
nnoremap <Space> :
vnoremap <Space> :

" search visual selection
vnoremap // y/<C-R>"<CR>

" Allow saving of files as sudo when you forgot to start vim using sudo
cnoremap w!! w suda://%

" gnu-make shortcuts
noremap <F3> :make clean<CR>
noremap <F4> :make -j`nproc`<CR>
noremap <F5> :make -j`nproc` runhw<CR>
noremap <F6> :make -j`nproc` debug<CR>
noremap <F7> :make -j`nproc` release<CR>

" disable search-highlighting
nnoremap <C-n> :noh<CR>

" navigate between buffers
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>bl :e#<CR>

" toggle NERDTree
nnoremap <leader>t :NERDTreeToggle<CR>

" double-escape to exit terminal-mode
tnoremap <Esc><Esc> <C-\><C-n>

" open .nvimrc in split window
nnoremap <leader>V :vs $MYVIMRC <CR>
nnoremap <leader>Va :vs $XDG_CONFIG_HOME/nvim/config/autocommands.vim <CR>
nnoremap <leader>Vk :vs $XDG_CONFIG_HOME/nvim/config/keys.vim <CR>
nnoremap <leader>Vh :vs $XDG_CONFIG_HOME/nvim/config/highlight.vim <CR>
nnoremap <leader>Vo :vs $XDG_CONFIG_HOME/nvim/config/options.vim <CR>
nnoremap <leader>Vp :vs $XDG_CONFIG_HOME/nvim/config/plugins.vim <CR>
nnoremap <leader>Vv :vs $XDG_CONFIG_HOME/nvim/config/variables.vim <CR>

" open .nvimrc in current window
nnoremap <leader>v :e $MYVIMRC <CR>
nnoremap <leader>va :e $XDG_CONFIG_HOME/nvim/config/autocommands.vim <CR>
nnoremap <leader>vk :e $XDG_CONFIG_HOME/nvim/config/keys.vim <CR>
nnoremap <leader>vh :e $XDG_CONFIG_HOME/nvim/config/highlight.vim <CR>
nnoremap <leader>vo :e $XDG_CONFIG_HOME/nvim/config/options.vim <CR>
nnoremap <leader>vp :e $XDG_CONFIG_HOME/nvim/config/plugins.vim <CR>
nnoremap <leader>vv :e $XDG_CONFIG_HOME/nvim/config/variables.vim <CR>

" you-complete-me "
nnoremap <Leader>yf :YcmCompleter FixIt<CR>

nnoremap <Leader>ygg :YcmCompleter GoTo<CR>
nnoremap <Leader>ygi :YcmCompleter GoToInclude<CR>
nnoremap <Leader>ygh :YcmCompleter GoToDeclaration<CR>
nnoremap <Leader>ygc :YcmCompleter GoToDefinition<CR>

nnoremap <Leader>yd :YcmCompleter GetDoc<CR>
nnoremap <Leader>yt :YcmCompleter GetType<CR>

nnoremap <Leader>yi :YcmDebugInfo<CR>
nnoremap <Leader>yr :YcmRestartServer<CR>
nnoremap <Leader>yl :YcmToggleLogs<CR>

" use TAB to cycle pop-up menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" git "
nnoremap <Leader>gb :Gblame<CR>
