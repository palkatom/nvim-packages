let feature#sessions#plugins = [
      \"vim-misc",
      \"vim-session",
      \]

function! feature#sessions#name()
  return xolox#session#find_current_session()
endfunction
