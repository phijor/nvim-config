if has("autocommands")
    if !exists("autocommands_firenvim_loaded")
        let autocommands_firenvim_loaded=1
        augroup FIRENVIM
            autocmd!
            au BufEnter github.com_*.txt set filetype=markdown
            au BufEnter couchdb.metricq.zih.tu-dresden.de_*doc-editor.txt set filetype=json
        augroup END
    endif
endif
