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

set updatetime=100
set signcolumn=yes

call feature_helpers#load_plugins(feature_git#plugins)
