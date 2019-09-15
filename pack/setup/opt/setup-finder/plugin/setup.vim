call setup#init_plugins(feature#finder#plugins)
" Download fzf binary automatically
" Seems to be available only on unix
if has("unix")
  let s:fzf_SID = helpers#get_SID(config#plugins#submodules_dir."/fzf/plugin/fzf.vim")
  execute "normal! :call <SNR>".s:fzf_SID."_fzf_exec()\<cr>y\<cr>"
endif
