" custom mappings
" let <Leader> be semicolon because '\' is just to far away
let mapleader = ';'
let maplocalleader = ';'

" map colon to space to save time
nnoremap <Space> :
vnoremap <Space> :

" search visual selection
vnoremap // y/<C-R>"<Enter>

" Allow saving of files as sudo when you forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

" gnu-make shortcuts
nmap <F3> :make clean<Enter>
nmap <F4> :make -j`nproc`<Enter>
nmap <F5> :make -j`nproc` runhw<Enter>
nmap <F6> :make -j`nproc` debug<Enter>
nmap <F7> :make -j`nproc` release<Enter>

" disable search-highlighting
nnoremap <C-n> :noh<Enter>

" exit terminal-mode
tnoremap <Esc> <C-\><C-n>

" exit to normal mode
inoremap <C-e> <Esc>
vnoremap <C-e> <Esc>
tnoremap <C-e> <C-\><C-n>

" open .nvimrc in split window
nmap <leader>V :vs $MYVIMRC <Enter>
nmap <leader>Va :vs $XDG_CONFIG_HOME/nvim/config/autocommands.vim <Enter>
nmap <leader>Vk :vs $XDG_CONFIG_HOME/nvim/config/keys.vim <Enter>
nmap <leader>Vh :vs $XDG_CONFIG_HOME/nvim/config/highlight.vim <Enter>
nmap <leader>Vo :vs $XDG_CONFIG_HOME/nvim/config/options.vim <Enter>
nmap <leader>Vp :vs $XDG_CONFIG_HOME/nvim/config/plugins.vim <Enter>
nmap <leader>Vv :vs $XDG_CONFIG_HOME/nvim/config/variables.vim <Enter>

" open .nvimrc in current window
nmap <leader>v :e $MYVIMRC <Enter>
nmap <leader>va :e $XDG_CONFIG_HOME/nvim/config/autocommands.vim <Enter>
nmap <leader>vk :e $XDG_CONFIG_HOME/nvim/config/keys.vim <Enter>
nmap <leader>vh :e $XDG_CONFIG_HOME/nvim/config/highlight.vim <Enter>
nmap <leader>vo :e $XDG_CONFIG_HOME/nvim/config/options.vim <Enter>
nmap <leader>vp :e $XDG_CONFIG_HOME/nvim/config/plugins.vim <Enter>
nmap <leader>vv :e $XDG_CONFIG_HOME/nvim/config/variables.vim <Enter>

" clang-format "
" nnoremap <Leader>cf :ClangFormat<CR>
" vnoremap <Leader>cf :ClangFormat<CR>

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
