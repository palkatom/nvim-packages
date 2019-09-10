" Load list of scripts in case of setup called manually
execute "source ".config#vim_home."/pack/features/opt/**/autoload/**/project.vim"
call setup#init_plugins(feature#project#plugins)

