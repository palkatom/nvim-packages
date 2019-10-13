if has("nvim-0.5.0")
  set wildcharm=<tab>
  cnoremap <expr> <left>  wildmenumode() ? "\<up>"    : "\<left>"
  cnoremap <expr> <right> wildmenumode() ? "\<down>"  : "\<right>"
  cnoremap <expr> <up>    wildmenumode() ? "\<left>"  : "\<up>"
  cnoremap <expr> <down>  wildmenumode() ? "\<right>" : "\<down>"
  cnoremap <expr> <c-h>   wildmenumode() ? "\<up>"    : "\<c-h>"
  cnoremap <expr> <c-l>   wildmenumode() ? "\<down>"  : "\<c-l>"
  cnoremap <expr> <c-k>   wildmenumode() ? "\<left>"  : "\<c-k>"
  cnoremap <expr> <c-j>   wildmenumode() ? "\<right>" : "\<c-j>"
endif
