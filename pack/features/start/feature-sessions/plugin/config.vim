let g:session_command_aliases = 1
let g:session_directory = expand(config#vim_home."/sessions")
set sessionoptions+=resize
let g:session_autoload = "no"
let g:session_autosave = "yes"
let g:session_default_to_last = 1

call feature_helpers#load_plugins(feature_sessions#plugins)
