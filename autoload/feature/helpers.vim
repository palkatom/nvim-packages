function! feature#helpers#load_plugins(plugins)
  for plugin in a:plugins
    execute "set runtimepath+=".g:config#plugins#submodules_dir."/".plugin
    execute "set runtimepath+=".g:config#plugins#submodules_dir."/".plugin."/after"
    execute "set runtimepath^=".g:config#plugins#submodules_dir
    execute "runtime! ".plugin."/plugin/**/*.vim"
    execute "runtime! ".plugin."/ftdetect/**/*.vim"
    execute "set runtimepath-=".g:config#plugins#submodules_dir
  endfor
endfunction
