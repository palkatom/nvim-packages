function! health#feature_project#check()
  call health_helpers#check_submodules_initialized(g:feature#project#plugins)
endfunction
