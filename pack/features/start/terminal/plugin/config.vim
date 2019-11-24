let g:neoterm_default_mod = "botright"
let g:neoterm_autoscroll = 1
let g:neoterm_term_per_tab = 1
let g:neoterm_autoinsert = 1
augroup terminal_auto_insert
  autocmd!
  autocmd BufEnter term://* startinsert
  autocmd BufLeave term://* stopinsert
augroup end

nmap <leader>tl :TREPLSendLine<cr>
nmap <leader>tf :TREPLSendFile<cr>
vmap <leader>t  :TREPLSendSelection<cr>

call commons#features#load_plugins(feature#terminal#plugins)
