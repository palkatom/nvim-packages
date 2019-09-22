function! s:shell_eol()
  if has("win32") || has("win64")
    return "\u000d"
  else
    return ""
  endif
endfunction
function! s:terminal_start(mods)
  " Do not open new terminal if there is already one in a tabpage, open it
  " instead (may be not the best idea - FIXME)
  " Idea is to use -bang attribute to allow adding more terminals to tabpage,
  " but I need to figure out how to handle case when multiple terminals are
  " opened and then closed (t:neoterm_id flag is cleared then)
  if exists("t:neoterm_id")
    Topen
    return
  endif
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
  call neoterm#do({"cmd": "cd ".l:working_dir.<SID>shell_eol()})
  " If pyenv is activated, activate it in terminal as well
  let l:pyenv_name = ""
  if exists("*Programming_PyenvName()")
    let l:pyenv_name = Programming_PyenvName()
  endif
  if !empty(l:pyenv_name) && exists("*Programming_PyenvRootDir()")
    call neoterm#do({"cmd": "source ".Programming_PyenvRootDir()."/bin/activate".<SID>shell_eol()})
  endif
endfunction
command! -bar Tnew call <SID>terminal_start(<q-mods>)

function! s:get_tab_terminal(terminal_number)
  " FIXME How to handle multiple tabpage terminals (see comment for
  " terminal_start function)
  if exists("t:neoterm_id")
    return t:neoterm_id
  endif
  return a:terminal_number
endfunction
command! -count=0 -complete=shellcmd -nargs=+ T call neoterm#do({"cmd": <q-args>.<SID>shell_eol(), "target": <SID>get_tab_terminal(<count>), "mods": <q-mods>})
