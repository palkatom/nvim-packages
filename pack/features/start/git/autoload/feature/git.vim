let feature#git#plugins = [
      \"vim-fugitive",
      \"vim-gitgutter",
      \]

function! feature#git#root_dir()
  let l:git_root_dir = FugitiveExtractGitDir(getcwd())
  if !empty(l:git_root_dir)
    let l:git_root_dir = fnamemodify(l:git_root_dir, ":h")
  endif
  return expand(l:git_root_dir)
endfunction

function! feature#git#head()
  return FugitiveHead(8)
endfunction

function! feature#git#is_git_buffer()
  return expand("%:p") =~# '\v^fugitive:[\\/]{2}'
endfunction

function! feature#git#diff_type()
  let l:git_buf_type = matchstr(expand("%:p"), '\v\.git[\\/]{2}\zs\c[0-9a-f]+\ze[\\/]')
  if empty(l:git_buf_type)
    echohl WarningMsg
    echomsg "Not in Git diff buffer"
    echohl None
    return ""
  endif
  if l:git_buf_type ==# "0"
    let l:type = "index"
  elseif l:git_buf_type ==# "2"
    let l:type = "current"
  elseif l:git_buf_type ==# "3"
    let l:type = "incoming"
  else
    let l:type = "(".l:git_buf_type[:7].")"
  endif
  return l:type
endfunction
