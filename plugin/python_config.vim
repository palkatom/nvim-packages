if isdirectory(config#python#py2_env_dir)
  let g:python_host_prog = config#python#py2_env_dir."/bin/python"
endif
if isdirectory(config#python#py3_env_dir)
  let g:python3_host_prog = config#python#py3_env_dir."/bin/python"
endif
