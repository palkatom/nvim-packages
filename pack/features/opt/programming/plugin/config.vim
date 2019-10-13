if exists("*Terminal_Type()")
  let g:test#strategy = Terminal_Type()
endif

call commons#features#load_plugins(feature#programming#plugins)

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
if executable("clangd-8")
  augroup cpp_lsp
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
          \"name": "clangd",
          \"cmd": {server_info->["clangd-8", "-background-index"]},
          \"whitelist": ["cpp", "cc", "objc", "objcpp", "c"]
          \})
  augroup end
endif
" Enable LSP explicitly as it can be loaded on-demand
call lsp#enable()
