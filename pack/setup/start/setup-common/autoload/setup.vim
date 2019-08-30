function! setup#init_plugins(plugins)
  for plugin in a:plugins
    set nomore
    echomsg "Setting up ".plugin." plugin"
    call helpers#echomsg_list(systemlist("git --git-dir ".g:config#vim_home."/.git".
          \" submodule update --init ".g:config#plugins#submodules_dir."/".plugin))
    set more
  endfor
endfunction

function! setup#get_SID(path)
  let l:scriptnames = split(execute("scriptnames"), "\n")
  for scriptline in l:scriptnames
    let scriptline = trim(scriptline)
    if scriptline =~# '\V'.a:path
      let l:SID = matchstr(l:scriptline, '\v^\d+')
      return l:SID
    endif
  endfor
  return 0
endfunction
