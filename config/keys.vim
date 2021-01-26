" custom mappings
" let <Leader> be semicolon because '\' is just to far away
let mapleader = ';'
let maplocalleader = ';'

" map colon to space to save time
nnoremap <Space> :
vnoremap <Space> :

nnoremap L <C-d>
vnoremap L <C-d>
nnoremap H <C-u>
vnoremap H <C-u>

" search visual selection
vnoremap // y/<C-R>"<CR>

" Allow saving of files as sudo when you forgot to start vim using sudo
cnoremap w!! w suda://%

" disable search-highlighting
nnoremap <C-n> <Cmd>noh<CR>

" navigate between buffers
nnoremap <leader>bn <Cmd>bnext<CR>
nnoremap <leader>bp <Cmd>bprev<CR>
nnoremap <leader>bl <Cmd>e#<CR>

" toggle NERDTree
nnoremap <leader>t <Cmd>NERDTreeToggle<CR>

" double-escape to exit terminal-mode
tnoremap <Esc><Esc> <C-\><C-n>

" open .nvimrc in split window
nnoremap <leader>V  <Cmd>vs $MYVIMRC <CR>
nnoremap <leader>Va <Cmd>vs $XDG_CONFIG_HOME/nvim/config/autocommands.vim <CR>
nnoremap <leader>Vk <Cmd>vs $XDG_CONFIG_HOME/nvim/config/keys.vim <CR>
nnoremap <leader>Vh <Cmd>vs $XDG_CONFIG_HOME/nvim/config/highlight.vim <CR>
nnoremap <leader>Vo <Cmd>vs $XDG_CONFIG_HOME/nvim/config/options.vim <CR>
nnoremap <leader>Vp <Cmd>vs $XDG_CONFIG_HOME/nvim/config/plugins.vim <CR>
nnoremap <leader>Vv <Cmd>vs $XDG_CONFIG_HOME/nvim/config/variables.vim <CR>

" open .nvimrc in current window
nnoremap <leader>v  <Cmd>e $MYVIMRC <CR>
nnoremap <leader>va <Cmd>e $XDG_CONFIG_HOME/nvim/config/autocommands.vim <CR>
nnoremap <leader>vk <Cmd>e $XDG_CONFIG_HOME/nvim/config/keys.vim <CR>
nnoremap <leader>vh <Cmd>e $XDG_CONFIG_HOME/nvim/config/highlight.vim <CR>
nnoremap <leader>vo <Cmd>e $XDG_CONFIG_HOME/nvim/config/options.vim <CR>
nnoremap <leader>vp <Cmd>e $XDG_CONFIG_HOME/nvim/config/plugins.vim <CR>
nnoremap <leader>vv <Cmd>e $XDG_CONFIG_HOME/nvim/config/variables.vim <CR>

nnoremap <leader>vck <Cmd>vs $XDG_CONFIG_HOME/nvim/config/coc/keys.vim <CR>

" fzf
nnoremap <Leader>o <Cmd>GFiles<CR>
nnoremap <Leader>O <Cmd>Files<CR>
nnoremap <Leader>b <Cmd>Buffers<CR>

" git "
nnoremap <Leader>gb <Cmd>Gblame<CR>
