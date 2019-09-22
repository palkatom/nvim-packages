set expandtab tabstop=4 softtabstop=4 shiftwidth=4 shiftround
set autoindent smartindent
augroup format_whitespaces
  autocmd!
  autocmd BufWrite * retab
  autocmd BufWrite * %s/\v\s+$//e
augroup end

function! s:add_empty_line(dir)
  let l:current_position = getcurpos()
  let l:new_position = l:current_position[1:2]
  if a:dir
    let l:where = l:new_position[0]
  else
    let l:where = l:new_position[0] - 1
    let l:new_position[0] = l:new_position[0] + 1
  endif
  call append(l:where, [""])
  call cursor(l:new_position)
endfunction
nnoremap <silent> [<space> :call <SID>add_empty_line(0)<cr>
nnoremap <silent> ]<space> :call <SID>add_empty_line(1)<cr>
