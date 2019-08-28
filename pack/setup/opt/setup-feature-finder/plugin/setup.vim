call setup#init_plugins(feature_finder#plugins)
" Download fzf binary automatically
" Seems to be available only on unix
if has("unix")
  let s:fzf_SID = setup#get_SID(config#plugins#submodules_dir."/fzf/plugin/fzf.vim")
  execute "normal! :call <SNR>".l:fzf_SID."_fzf_exec()\<cr>y\<cr>"
endif
