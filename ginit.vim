if exists("g:GuiLoaded")
  if has("win32") || has("win64")
    call GuiClipboard()

    GuiTabline 0
    GuiPopupmenu 0
  endif
  call GuiWindowMaximized(1)
  call GuiMousehide(1)

  nnoremap <F11> :call GuiWindowFullScreen(!g:GuiWindowFullScreen)<cr>

  if has("unix")
    GuiFont Fira Code:h12
  endif
endif

execute "cd $HOME"
