let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsRemoveSelectModeMappings = 0

call commons#features#load_plugins(feature#snippets#plugins)

call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
      \"name": "ultisnips",
      \"whitelist": ['*'],
      \"completor": function('asyncomplete#sources#ultisnips#completor'),
      \}))
