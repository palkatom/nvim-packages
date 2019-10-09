function! health#feature_snippets#check()
  call health_helpers#check_submodules_initialized(g:feature#snippets#plugins)
endfunction
