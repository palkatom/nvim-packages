function! s:shell_eol()
  if has("win32") || has("win64")
    return "\u000d"
  else
    return ""
  endif
endfunction
function! s:clear_line_command()
  if &shell =~# "bash"
    return "\u0005\u0015" " Ctrl-E Ctrl-U
  elseif &shell =~# "cmd.exe"
    return "\u001b" " Esc
  endif
endfunction
function! s:terminal_start(mods)
  " Do not open new terminal if there is already one in a tabpage, open it
  " instead (may be not the best idea - FIXME)
  " Idea is to use -bang attribute to allow adding more terminals to tabpage,
  " but I need to figure out how to handle case when multiple terminals are
  " opened and then closed (t:neoterm_id flag is cleared then)
  if exists("t:neoterm_id") && a:mods !~# 'tab'
    execute "Topen"
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
  sleep 200m
  " Go to the working directory
  call neoterm#do({"cmd": "cd ".l:working_dir.<SID>shell_eol(), "target": g:neoterm.last_id})
  " If pyenv is activated, activate it in terminal as well
  let l:pyenv_name = ""
  if exists("*Programming_PyenvName()")
    let l:pyenv_name = Programming_PyenvName()
  endif
  " TODO: Windows support
  if !empty(l:pyenv_name) && exists("*Programming_PyenvRootDir()")
    call neoterm#do({"cmd": "source ".Programming_PyenvRootDir()."/bin/activate".<SID>shell_eol()})
  endif
endfunction
command! -bar Tnew call <SID>terminal_start(<q-mods>)

function! s:get_tab_terminal(terminal_number)
  " FIXME How to handle multiple tabpage terminals (see comment for
  " terminal_start function)
  if a:terminal_number == 0 && exists("t:neoterm_id")
    return t:neoterm_id
  endif
  return a:terminal_number
endfunction
command! -count=0 -complete=shellcmd -nargs=+ T call neoterm#do({"cmd": <q-args>.<SID>shell_eol(), "target": <SID>get_tab_terminal(<count>), "mod": <q-mods>})

function! s:terminal_exit(terminal_id, mods)
  let l:terminal_id = s:get_tab_terminal(a:terminal_id)
  function! s:close_terminal(terminal_id, mods)
    call neoterm#do({"cmd": <SID>clear_line_command()."exit".<SID>shell_eol(),
          \"target": a:terminal_id,
          \"mod": a:mods
          \})
  endfunction
  " Ensure terminal_id exists
  if !has_key(g:neoterm.instances, l:terminal_id)
    return
  endif
  let l:buffer_id = g:neoterm.instances[l:terminal_id].buffer_id
  " Find tabpage with given terminal id
  for tabpage in range(1, tabpagenr("$"))
    let l:tabpagebuffers = uniq(sort(tabpagebuflist(tabpage)))
    if index(l:tabpagebuffers, l:buffer_id) >= 0
      " Is it the only buffer in tabpage?
      if len(l:tabpagebuffers) == 1
        " Terminal is the only buffer, prevent closing tabpage prematurely
        execute tabpage."tabdo new"
        call s:close_terminal(l:terminal_id, a:mods)
        call wait(500, 'tabpagewinnr(tabpage, "$") == 1', 50)
        execute tabpage."tabdo tabclose"
      else
        call s:close_terminal(l:terminal_id, a:mods)
      endif
      break
    endif
  endfor
endfunction
command! -count=0 -nargs=0 Texit call <SID>terminal_exit(<count>, <q-mods>)
