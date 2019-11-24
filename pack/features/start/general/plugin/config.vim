nmap <leader>= <Plug>(EasyAlign)
vmap <leader>= <Plug>(EasyAlign)

let g:sneak#label = 1

let g:pear_tree_ft_disabled = [
      \"vim",
      \]
let g:pear_tree_repeatable_expand = 0
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1

call commons#features#load_plugins(feature#general#plugins)
