if has("win32") || has("win64")
  call GuiClipboard()

  GuiTabline 0
  GuiPopupmenu 0
endif
call GuiWindowMaximized(1)
call GuiMousehide(1)

function! s:toggle_fullscreen()
  if g:GuiWindowFullScreen
    let l:set_flag = 0
  else
    let l:set_flag = 1
  endif
  call GuiWindowFullScreen(l:set_flag)
endfunction
nnoremap <F11> :call <SID>toggle_fullscreen()<cr>

if has("unix")
  GuiFont Hack:h12
endif

execute "cd $HOME"
