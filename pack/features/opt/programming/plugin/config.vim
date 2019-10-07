if exists("*Terminal_Type()")
  let g:test#strategy = Terminal_Type()
endif

silent packadd setup-programming
call feature#helpers#load_plugins(feature#programming#plugins)

" Register servers
if executable("pyls")
  augroup python_lsp
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \"name": "pyls",
          \"cmd": {server_info->["pyls"]},
          \"whitelist": ["python"],
          \})
  augroup end
endif
call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
      \"name": "ultisnips",
      \"whitelist": ["*"],
      \"completor": function("asyncomplete#sources#ultisnips#completor"),
      \}))
" Enable LSP explicitly as it can be loaded on-demand
call lsp#enable()
