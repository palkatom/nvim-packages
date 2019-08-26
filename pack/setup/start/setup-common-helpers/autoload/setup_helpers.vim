function! setup_helpers#echomsg_list(msgs)
  for msg in a:msgs
    echomsg(msg)
  endfor
endfunction
