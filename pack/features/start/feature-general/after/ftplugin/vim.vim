let b:autopairs_enabled = 0
if !exists("b:undo_ftplugin")
  let b:undo_ftplugin = ""
endif
let b:undo_ftplugin .= "|let b:autopairs_enabled = 1"
