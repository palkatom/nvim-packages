let s:plugins = [
      \"vim-surround",
      \"vim-polyglot",
      \"auto-pairs",
      \"vim-easy-align",
      \"vim-sneak",
      \"vim-commentary",
      \"vim-vinegar",
      \]
for s:plugin in s:plugins
  echomsg "Setting up ".s:plugin." plugin"
  call setup_helpers#echomsg_list(systemlist("git --git-dir ".config#vim_home."/.git".
        \" submodule update --init ".config#plugins#submodules_dir."/".s:plugin))
endfor
