let feature#terminal#plugins = [
      \"neoterm",
      \]

function! s:get_bufname(bufnr)
  if a:bufnr == 0
    let l:bufname = expand("%:p")
  else
    let l:bufname = bufname(a:bufnr)
  endif
  return l:bufname
endfunction

function! feature#terminal#is_term_buffer(bufnr)
  let l:bufname = s:get_bufname(a:bufnr)
  return l:bufname =~# '\v^term:'
endfunction

function! feature#terminal#name()
  let l:bufname = s:get_bufname(a:bufnr)
  let l:name = matchstr(split(l:bufname)[0], '\v\/\zs[^/]*$')
  if feature#terminal#is_term_buffer(a:bufnr) && exists("t:neoterm_id")
    return l:name.":#".t:neoterm_id
  endif
  return l:name
endfunction

function! feature#terminal#type()
  return "neoterm"
endfunction
