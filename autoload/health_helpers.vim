let s:plugins_dir = fnamemodify(g:config#plugins#submodules_dir, ":t")

function! s:check_submodule_initialized(plugin)
  return system("cd ".g:config#vim_home." && ".
        \"git submodule status ".s:plugins_dir."/".a:plugin)[0] !=# '-'
endfunction

function! s:check_submodule_changes(plugin)
  return len(system("cd ".g:config#plugins#submodules_dir."/".a:plugin." && ".
        \"git status --short"))
endfunction

function! health_helpers#check_submodules_initialized(plugins)
  call health#report_start("Check general plugins availability")
  for plugin in a:plugins
    if !s:check_submodule_initialized(plugin)
      call health#report_error("Git submodule for ".plugin." is not initialized",
            \["git submodule update --init ".s:plugins_dir."/".plugin])
    else
      if s:check_submodule_changes(plugin)
        call health#report_warn("Git submodule for ".plugin." has changes. It may not work well.",
              \["git status", "git restore ."])
      else
        call health#report_ok(plugin)
      endif
    endif
  endfor
endfunction

