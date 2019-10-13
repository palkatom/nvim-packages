function! commons#features#load_plugins(plugins)
  for plugin in a:plugins
    let l:first_after_idx = match(split(&runtimepath, ","), '\v[\\/]after$')
    call s:insert_into_rtp(g:config#plugins#submodules_dir."/".plugin."/after", l:first_after_idx)
    call s:insert_into_rtp(g:config#plugins#submodules_dir."/".plugin, 1)
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
  call s:insert_into_rtp(g:config#plugins#submodules_dir, 0)
  " load plugin
  execute "runtime! ".a:plugin."/ftdetect/**/*.vim"
  execute "runtime! ".a:plugin."/plugin/**/*.vim"
  " Remove plugins directory
  let &runtimepath = join(split(&runtimepath, ",")[1:], ",")
endfunction
