let g:neoterm_default_mod = "botright"
let g:neoterm_autoscroll = 1
let g:neoterm_term_per_tab = 1
let g:neoterm_autoinsert = 1
augroup terminal_auto_insert
  autocmd!
  autocmd BufEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
augroup end

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
  let l:name = matchstr(split(l:bufname)[0], '\v\/\zs[^/]*$')
  if Terminal_IsTermBuffer(a:bufnr) && exists("t:neoterm_id")
    return l:name.":#".t:neoterm_id
  endif
  return l:name
endfunction

function! Terminal_Type()
  return "neoterm"
endfunction

nmap <leader>tl :TREPLSendLine<cr>
nmap <leader>tf :TREPLSendFile<cr>
vmap <leader>t  :TREPLSendSelection<cr>

call commons#features#load_plugins(feature#terminal#plugins)
