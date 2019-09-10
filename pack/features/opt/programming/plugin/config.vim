if exists("*Terminal_Type()")
  let g:test#strategy = Terminal_Type()
endif

silent packadd setup-programming
call feature#helpers#load_plugins(feature#programming#plugins)
