let g:neoterm_default_mod = "botright"
let g:neoterm_autoscroll = 1
let g:neoterm_term_per_tab = 1

function! s:get_bufname(bufnr)
  if a:bufnr == 0
    let l:bufname = expand("%:p")
  else
    let l:bufname = bufname(a:bufnr)
  endif
  return l:bufname
endfunction

function! Terminal_IsTermBuffer(bufnr)
  let l:bufname = s:get_bufname(a:bufnr)
  return l:bufname =~# '\v^term:'
endfunction

function! Terminal_Name(bufnr)
  let l:bufname = s:get_bufname(a:bufnr)
  return matchstr(split(l:bufname)[0], '\v\/\zs[^/]*$')
endfunction

function! Terminal_Type()
  return "neoterm"
endfunction

call feature#helpers#load_plugins(feature#terminal#plugins)
