let g:one_allow_italics = 1

call feature_helpers#load_plugins(feature_theme#plugins)

syntax on
set background=dark
colorscheme one
highlight! link Folded FoldColumn
highlight! link VertSplit StatusLineNC
let &fillchars = "vert:\ "
