function! feature_helpers#load_plugins(plugins)
  for plugin in a:plugins
    execute "packadd ".plugin
  endfor
endfunction
