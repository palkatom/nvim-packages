function! health#feature_general#check()
  call s:check_submodules_initialized()
endfunction

function! s:check_submodules_initialized()
  call health#report_start("Check general plugins availability")
  for plugin in g:feature#general#plugins
    echo plugin
  endfor
endfunction
