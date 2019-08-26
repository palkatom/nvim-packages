function! setup_helpers#echomsg_list(msgs)
  set nomore
  for msg in a:msgs
    echomsg(msg)
  endfor
  set more
endfunction
