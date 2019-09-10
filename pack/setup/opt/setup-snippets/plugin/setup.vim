" Load list of scripts in case of setup called manually
execute "source ".config#vim_home."/pack/features/opt/**/autoload/**/snippets.vim"
call setup#init_plugins(feature#snippets#plugins)
