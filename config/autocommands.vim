if has("autocmd")
    if !exists("autocommands_loaded")
        let autocommands_loaded = 1
        augroup startup
            autocmd!
            autocmd VimEnter * let $EDITOR = 'nvr -cc split --remote-wait-silent'
            autocmd VimEnter * let $VISUAL = 'nvr -cc split --remote-wait-silent'
        augroup END
        augroup vimrchooks
            autocmd!
            autocmd bufwritepost $MYVIMRC source $MYVIMRC
            autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
        augroup END
        augroup jshooks
            autocmd!
            autocmd BufNewFile,BufRead,BufEnter *.js set omnifunc=javascriptcomplete#CompleteJS
        augroup END
        augroup NERDTree
            autocmd!
            " autocmd VimEnter * NERDTree | wincmd p
            autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
        augroup END
        augroup Quickfix
            autocmd QuickFixCmdPost [^l]* nested cwindow
            autocmd QuickFixCmdPost    l* nested lwindow
        augroup END
        " augroup Haskell
        "     autocmd BufEnter *.hs compiler ghc
        " augroup END
        augroup Octave
            autocmd BufNewFile,BufRead *.m set filetype=octave
        augroup END
        augroup CPP
            autocmd BufNewFile,BufRead *.hh set filetype=cpp
            autocmd BufNewFile,BufRead *.tpp set filetype=cpp
        augroup END
        augroup highlighting
            autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
            autocmd InsertLeave * match ExtraWhitespace /\s\+$/
        augroup END
        augroup CodeFormat
            autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :ClangFormat<CR>
            autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
            autocmd FileType rust nnoremap <buffer><Leader>cf :RustFmt<CR>
            autocmd FileType rust vnoremap <buffer><Leader>cf :RustFmt<CR>
        augroup END
    endif
endif

