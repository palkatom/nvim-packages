function! health#feature_finder#check()
  call health_helpers#check_submodules_initialized(g:feature#finder#plugins)
  call s:check_fzf_executable()
endfunction

function! s:check_fzf_executable()
  call health#report_start("Check fzf executable")
  if has("win32") || has("win64")
    let l:ext = ".exe"
  else
    let l:ext = ""
  endif
  if filereadable(g:config#plugins#submodules_dir."/fzf/bin/fzf".l:ext) || executable("fzf")
    call health#report_ok("fzf executable found")
  else
    if has("win32") || has("win64")
      call health#report_error("fzf executable not found in PATH",
            \["Download fzf binary for Windows from https://github.com/junegunn/fzf-bin/releases/ and place it as ".
            \ g:config#plugins#submodules_dir."fzf\bin\fzf.exe"])
    else
      call health#report_warn("fzf executable not found in PATH",
            \["fzf executable can be installed during first fzf-command call"])
    endif
  endif
endfunction
