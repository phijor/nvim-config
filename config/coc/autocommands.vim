if has("autocommands")
    if !exists("autocommands_coc_loaded")
        let autocommands_coc_loaded=1
        augroup COC
            autocmd!
            autocmd CursorHold * silent call CocActionAsync('highlight')
        augroup END
    endif
endif
