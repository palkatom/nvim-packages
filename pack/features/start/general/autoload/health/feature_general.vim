function! health#feature_general#check()
  call health_helpers#check_submodules_initialized(g:feature#general#plugins)
endfunction
