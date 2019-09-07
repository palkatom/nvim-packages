function! s:projectionist_run_on_init() abort
  for [root, vim_command] in projectionist#query("on_vim_init")
    echomsg "Executing project init command: ".vim_command
    execute vim_command
    break
  endfor
endfunction
augroup projectionist_on_init
  autocmd!
  autocmd User ProjectionistActivate call <SID>projectionist_run_on_init()
augroup end

function! Project_RootDir()
  return projectionist#path()
endfunction

" Always setup optional feature
silent packadd setup-project
call feature#helpers#load_plugins(feature#project#plugins)
