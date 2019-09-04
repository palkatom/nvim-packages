function! feature#helpers#load_plugins(plugins)
  for plugin in a:plugins
    execute "set runtimepath+=".g:config#plugins#submodules_dir."/".plugin
    execute "runtime! plugins/".plugin."/plugin/**/*.vim"
  endfor
endfunction
