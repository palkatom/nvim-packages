set number relativenumber numberwidth=5
let &listchars = "tab:\u00bb\ ,trail:\u2423"
set list
set nowrap sidescroll=35
let &listchars .= ",precedes:\u27ea,extends:\u27eb"
set noequalalways

augroup colorcolumn_in_active_window
  autocmd!
  autocmd BufNewFile,BufRead,BufWinEnter,WinEnter * let &l:colorcolumn = "80,".join(range(120, 999), ",")
  autocmd WinLeave * let &l:colorcolumn = join(range(1, 999), ",")
augroup end
augroup cursorline_in_active_window
  autocmd!
  autocmd BufNewFile,BufRead,BufWinEnter,WinEnter * if !&diff|setlocal cursorline|else|setlocal nocursorline|endif
  autocmd WinLeave * setlocal nocursorline
  autocmd VimEnter * setlocal cursorline
augroup end

function! s:disable_cursorline_in_diff(new_option_value)
  if a:new_option_value
    setlocal nocursorline
  else
    setlocal cursorline
  endif
endfunction
augroup cursorline_in_diff_windows
  autocmd!
  autocmd OptionSet diff call <SID>disable_cursorline_in_diff(v:option_new)
augroup end

set scrolloff=3
