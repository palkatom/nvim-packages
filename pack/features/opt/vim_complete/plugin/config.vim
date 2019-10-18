augroup vim_complete
  autocmd!
  autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
        \"name": "necosyntax",
        \"whitelist": ["*"],
        \"completor": function("asyncomplete#sources#necosyntax#completor"),
        \}))
  autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
        \"name": "necovim",
        \"whitelist": ["vim"],
        \"completor": function("asyncomplete#sources#necovim#completor"),
        \}))
augroup end

call commons#features#load_plugins(feature#vim_complete#plugins)
