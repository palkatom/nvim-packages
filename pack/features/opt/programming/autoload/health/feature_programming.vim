function! health#feature_programming#check()
  call health_helpers#check_submodules_initialized(g:feature#programming#plugins)
endfunction
