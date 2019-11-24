function! s:setup_float_win()
  function! s:get_win_ids()
    return map(range(1, winnr("$")), 'win_getid(v:val)')
  endfunction
  " Record current window ids
  let l:current_wins = s:get_win_ids()
  " Trigger hover function from LSP
  call lsp#ui#vim#hover#get_hover_under_cursor()
  " Wait until floating window is displayed
  silent call wait(1000, 'winnr("$") > len(l:current_wins)', 50)
  " Get new window ids
  let l:new_wins = s:get_win_ids()
  " Find new window id
  for winid in l:new_wins
    if index(l:current_wins, winid) < 0
      let l:float_win_id = winid
      break
    endif
  endfor
  " Set minimal style for floating window
  if exists("l:float_win_id")
    call nvim_win_set_config(l:float_win_id, {"style": "minimal"})
  endif
endfunction

" Overwrite LspHover command
command! LspHover call <SID>setup_float_win()
