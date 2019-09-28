function! health#feature_sessions#check()
  call health_helpers#check_submodules_initialized(g:feature#sessions#plugins)
endfunction
