function! commons#get_SID(path)
  let l:scriptnames = split(execute("scriptnames"), "\n")
  for scriptline in l:scriptnames
    let scriptline = trim(scriptline)
    if scriptline =~# '\V'.escape(fnamemodify(a:path, ":~"), '\')
      let l:SID = matchstr(l:scriptline, '\v^\d+')
      return l:SID
    endif
  endfor
  return 0
endfunction
