function! s:terminal_start(mods)
  " Start terminal in:
  "   project root,
  "   git root,
  "   current file's directory or
  "   current working directory
  let l:working_dir = ""
  if exists("*Project_RootDir()")
    let l:working_dir = Project_RootDir()
  endif
  if empty(l:working_dir) && exists("*Git_RootDir()")
    let l:working_dir = Git_RootDir()
  endif
  if empty(l:working_dir)
    let l:working_dir = expand("%:p:h")
  endif
  if empty(l:working_dir)
    let l:working_dir = expand(getcwd())
  endif
  " Start terminal
  call neoterm#new({"mod": a:mods})
  " Go to the working directory
  call neoterm#do({"cmd": "cd ".l:working_dir})
  " If pyenv is activated, activate it in terminal as well
  let l:pyenv_name = ""
  if exists("*Programming_PyenvName()")
    let l:pyenv_name = Programming_PyenvName()
  endif
  if !empty(l:pyenv_name) && exists("*Programming_PyenvRootDir()")
    call neoterm#do({"cmd": "source ".Programming_PyenvRootDir()."/bin/activate"})
  endif
endfunction

command! -bar Tnew call <SID>terminal_start(<q-mods>)
command! -range=0 -complete=shellcmd -nargs=+ T call neoterm#do({"cmd": <q-args>, "target": <count>, "mods": <q-mods>})
