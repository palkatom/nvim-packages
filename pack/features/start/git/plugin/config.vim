set updatetime=100
set signcolumn=yes
let g:gitgutter_diff_args = '--ignore-space-at-eol'

function! s:new_branch(branch_name)
  execute "!git checkout -b ".a:branch_name
endfunction
command! -nargs=1 GnewBranch call <SID>new_branch("<args>")
nnoremap <leader>gn :GnewBranch<space>

call commons#features#load_plugins(feature#git#plugins)
