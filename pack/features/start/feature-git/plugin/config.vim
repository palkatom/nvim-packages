function! Git_RootDir()
  let l:git_root_dir = FugitiveExtractGitDir(getcwd())
  if !empty(l:git_root_dir)
    let l:git_root_dir = fnamemodify(l:git_root_dir, ":h")
  endif
  return expand(l:git_root_dir)
endfunction
function! Git_Head()
  return FugitiveHead(8)
endfunction
function! Git_IsGitBuffer()
  return expand("%:p") =~# '\v^fugitive:[\\/]{2}'
endfunction
function! Git_DiffType()
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

set updatetime=100
set signcolumn=yes

call feature_helpers#load_plugins(feature_git#plugins)
