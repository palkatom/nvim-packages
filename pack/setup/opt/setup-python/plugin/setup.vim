if has("unix")
  if !executable("python2") || !executable("python3")
    echohl WarningMsg
    echomsg "python2 or python3 executable not found. Cannot setup python support. Please install both 'python2' and 'python3'. Finishing setup."
    echohl None
    finish
  else
    echomsg "Setting up python support..."
    let s:commands = [
          \"python3 -m pip install virtualenv",
          \"python3 -m virtualenv ".config#python#py3_env_dir,
          \"python3 -m virtualenv -p python2 ".config#python#py2_env_dir,
          \"source ".config#python#py3_env_dir."/bin/activate && pip install pynvim",
          \"source ".config#python#py2_env_dir."/bin/activate && pip install pynvim",
          \]
    for s:command in s:commands
      call setup_helpers#echomsg_list(systemlist(s:command))
    endfor
    runtime plugin/python_config.vim
  endif
endif
