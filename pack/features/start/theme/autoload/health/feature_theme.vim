function! health#feature_theme#check()
  call health_helpers#check_submodules_initialized(g:feature#theme#plugins)
endfunction
