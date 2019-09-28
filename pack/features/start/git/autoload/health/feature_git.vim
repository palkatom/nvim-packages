function! health#feature_git#check()
  call health_helpers#check_submodules_initialized(g:feature#git#plugins)
endfunction
