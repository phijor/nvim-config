if has("autocommands")
    if !exists("autocommands_coc_loaded")
        let autocommands_coc_loaded=1
        augroup COC
            autocmd!
            autocmd CursorHold * silent call CocActionAsync('highlight')
            " Setup formatexpr specified filetype(s).
            autocmd FileType rust setl formatexpr=CocAction('formatSelected')
        augroup END
    endif
endif
