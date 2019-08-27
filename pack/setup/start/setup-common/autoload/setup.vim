function! setup#init_plugins(plugins)
  for plugin in a:plugins
    set nomore
    echomsg "Setting up ".plugin." plugin"
    call helpers#echomsg_list(systemlist("git --git-dir ".g:config#vim_home."/.git".
          \" submodule update --init ".g:config#plugins#submodules_dir."/".plugin))
    set more
  endfor
endfunction
