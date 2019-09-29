if exists("*Terminal_Type()")
  let g:test#strategy = Terminal_Type()
endif

" LSP-related settings

silent packadd setup-programming
call feature#helpers#load_plugins(feature#programming#plugins)

" Enable LSP explicitly as it is loaded on-demand
call lsp#enable()
