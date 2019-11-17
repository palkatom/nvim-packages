function! commons#features#load_plugins(plugins)
  for plugin in a:plugins
    let l:first_after_idx = match(split(&runtimepath, ","), '\v[\\/]after$')
    call s:insert_into_rtp(g:config#plugins#directory."/".plugin."/after", l:first_after_idx)
    call s:insert_into_rtp(g:config#plugins#directory."/".plugin, 1)
    call s:load_plugin(plugin)
  endfor
endfunction

function! s:insert_into_rtp(path_elem, idx)
  let l:rtp_list = split(&runtimepath, ",")
  let l:new_rtp_list = insert(l:rtp_list, a:path_elem, a:idx)
  let &runtimepath = join(l:new_rtp_list, ",")
endfunction

function! s:load_plugin(plugin)
  " Add plugins directory for manual loading
  call s:insert_into_rtp(g:config#plugins#directory, 0)
  " load plugin
  execute "runtime! ".a:plugin."/ftdetect/**/*.vim"
  execute "runtime! ".a:plugin."/plugin/**/*.vim"
  " Remove plugins directory
  let &runtimepath = join(split(&runtimepath, ",")[1:], ",")
  " generate help tags for loaded plugins
  let l:plugin_doc_dir = expand(g:config#plugins#directory."/".a:plugin."/doc")
  if isdirectory(l:plugin_doc_dir)
    execute "helptags ".g:config#plugins#directory."/".a:plugin."/doc"
  endif
endfunction
