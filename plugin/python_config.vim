if has("win32") || has("win64")
  let s:python_basedir = "Scripts"
  let s:python_ext = ".exe"
else
  let s:python_basedir = "bin"
  let s:python_ext = ""
endif
if isdirectory(config#python#py2_env_dir)
  let g:python_host_prog = expand(config#python#py2_env_dir."/".s:python_basedir."/python".s:python_ext)
endif
if isdirectory(config#python#py3_env_dir)
  let g:python3_host_prog = expand(config#python#py3_env_dir."/".s:python_basedir."/python".s:python_ext)
endif
