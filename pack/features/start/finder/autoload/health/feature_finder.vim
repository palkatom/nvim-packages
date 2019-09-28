function! health#feature_finder#check()
  call health_helpers#check_submodules_initialized(g:feature#finder#plugins)
endfunction
