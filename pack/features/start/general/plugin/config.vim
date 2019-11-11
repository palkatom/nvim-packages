nmap <leader>= <Plug>(EasyAlign)
vmap <leader>= <Plug>(EasyAlign)

let g:sneak#label = 1

let g:rainbow_active = 1

function! s:search_for(character, count, direction)
  " direction=0 means backward, direction=1 means forward
  let l:direction_flag = a:direction ? "" : "b"
  for _ in range(a:count)
    call search('\V'.a:character, "Ws".l:direction_flag)
  endfor
  let l:prefix = a:direction ? "g" : "G"
  silent! call repeat#set(l:prefix.a:character, -1)
endfunction
nnoremap <silent> g( :<c-u>call <SID>search_for('(', v:count1, 1)<cr>
nnoremap <silent> G( :<c-u>call <SID>search_for('(', v:count1, 0)<cr>
nnoremap <silent> g) :<c-u>call <SID>search_for(')', v:count1, 1)<cr>
nnoremap <silent> G) :<c-u>call <SID>search_for(')', v:count1, 0)<cr>
nnoremap <silent> g[ :<c-u>call <SID>search_for('[', v:count1, 1)<cr>
nnoremap <silent> G[ :<c-u>call <SID>search_for('[', v:count1, 0)<cr>
nnoremap <silent> g] :<c-u>call <SID>search_for(']', v:count1, 1)<cr>
nnoremap <silent> G] :<c-u>call <SID>search_for(']', v:count1, 0)<cr>
nnoremap <silent> g{ :<c-u>call <SID>search_for('{', v:count1, 1)<cr>
nnoremap <silent> G{ :<c-u>call <SID>search_for('{', v:count1, 0)<cr>
nnoremap <silent> g} :<c-u>call <SID>search_for('}', v:count1, 1)<cr>
nnoremap <silent> G} :<c-u>call <SID>search_for('}', v:count1, 0)<cr>
nnoremap <silent> g< :<c-u>call <SID>search_for('<', v:count1, 1)<cr>
nnoremap <silent> G< :<c-u>call <SID>search_for('<', v:count1, 0)<cr>
nnoremap <silent> g> :<c-u>call <SID>search_for('>', v:count1, 1)<cr>
nnoremap <silent> G> :<c-u>call <SID>search_for('>', v:count1, 0)<cr>
nnoremap <silent> g" :<c-u>call <SID>search_for('"', v:count1, 1)<cr>
nnoremap <silent> G" :<c-u>call <SID>search_for('"', v:count1, 0)<cr>
nnoremap <silent> g' :<c-u>call <SID>search_for("'", v:count1, 1)<cr>
nnoremap <silent> G' :<c-u>call <SID>search_for("'", v:count1, 0)<cr>
nnoremap GG G

call commons#features#load_plugins(feature#general#plugins)
