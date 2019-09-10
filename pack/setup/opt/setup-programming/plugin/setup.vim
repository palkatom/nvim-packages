" Load list of scripts in case of setup called manually
execute "source ".config#vim_home."/pack/features/opt/**/autoload/**/programming.vim"
call setup#init_plugins(feature#programming#plugins)
