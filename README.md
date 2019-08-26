# nvim-packages

## Directory layout

```
.config/nvim
├── after
│   └── ftplugin
├── autoload
├── pack
│   ├── features
│   │   ├── opt
│   │   │   ├── feature-programming
│   │   │   │   └── plugin
│   │   │   └── feature-snippets
│   │   │       └── plugin
│   │   └── start
│   │       ├── feature-finder
│   │       │   └── plugin
│   │       ├── feature-general
│   │       │   └── plugin
│   │       ├── feature-git
│   │       │   └── plugin
│   │       ├── feature-sessions
│   │       │   └── plugin
│   │       ├── feature-terminal
│   │       │   └── plugin
│   │       └── feature-theme
│   │           └── plugin
│   └── setup
│       ├── opt
│       │   └── setup-python
│       │       └── plugin
│       └── start
│           └── setup-common-helpers
│               └── autoload
└── plugin
    ├── python_config.vim
    └── visual.vim
```

* `pack/plugins/opt`
  Stores vim plugins that are used inside *features*. Plugins are loaded as part
  of features.
* `pack/features/start`
  Configuration for *features* - sets of related plugins. `opt` sudirectory for
  experimental or rarely used *features*.
* `pack/setup/opt`
  One time installation and setup scripts. Downloads plugins for use in *features*.
* `pack/setup/start`
  Helpers and common things for setup scripts.
* `after/ftplugin`, `plugin`, `autoload`, etc.
  Common configuration that doesn't depend on any plugins.
