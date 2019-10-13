let g:fzf_layout = {"window": "botright 12 split enew"}

function! s:find_in_git_files_first()
  let l:output = execute("GitFiles")
  if l:output =~? "Not in git repo"
    execute "Files"
  endif
endfunction
nnoremap <silent> <c-s>f :call <SID>find_in_git_files_first()<cr>

function! s:find_git_branches()
  " Does not create branches #TODO
  let l:dict = {"source": "git branch -a"}
  function! l:dict.sink(lines)
    " Current branch is marked with '*' - do nothing in this case
    if a:lines !~ '\v^\s*\*'
      let l:remote_branch_name_pattern = '\v^\s*remotes/[^/]*/\zs.*\ze$'
      if a:lines =~# l:remote_branch_name_pattern
        let l:branch_name = matchstr(a:lines, l:remote_branch_name_pattern)
      else
        let l:branch_name = a:lines
      endif
      execute "!git checkout ".l:branch_name
    endif
  endfunction
  call fzf#run(fzf#wrap(l:dict))
endfunction
command! -nargs=0 Branches call <SID>find_git_branches()
nnoremap <silent> <c-s>gb :Branches<cr>

nnoremap <silent> <c-s>b :Buffers<cr>

call commons#features#load_plugins(feature#finder#plugins)
