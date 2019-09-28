function! health#feature_terminal#check()
  call health_helpers#check_submodules_initialized(g:feature#terminal#plugins)
endfunction
