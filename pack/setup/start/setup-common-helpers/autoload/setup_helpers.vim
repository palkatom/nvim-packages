function! setup_helpers#echomsg_list(msgs)
  for msg in a:msgs
    echomsg(msg)
  endfor
endfunction
function! setup_helpers#load_plugins(plugins)
  for plugin in a:plugins
    execute "packadd ".plugin
  endfor
endfunction
