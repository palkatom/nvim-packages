for s:plugin in feature_general#plugins
  set nomore
  echomsg "Setting up ".s:plugin." plugin"
  call setup_helpers#echomsg_list(systemlist("git --git-dir ".config#vim_home."/.git".
        \" submodule update --init ".config#plugins#submodules_dir."/".s:plugin))
  set more
endfor
