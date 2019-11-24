let feature#project#plugins = [
      \"vim-projectionist",
      \]

function! feature#project#root_dir()
  return projectionist#path()
endfunction
