# nvim-packages

## Directory layout

```
.config/nvim
├── after
│   └── ftplugin
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
│   └── plugins
│       └── opt
└── plugin
```

* `pack/plugins/opt`
  Stores vim plugins that are used inside *features*. Plugins are loaded as part
  of features.
* `pack/features/start`
  Configuration for *features* - sets of related plugins. `opt` sudirectory for
  experimental or rarely used *features*.
* `after/ftplugin`, `plugin`, `autoload`, etc.
  Common configuration that doesn't depend on any plugins.
