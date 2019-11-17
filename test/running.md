# Running tests

* run nvim using following command:
    ```bash
    nvim --cmd 'set rtp+=test/vader/' +'runtime! test/vader/ftdetect/**/*.vim|runtime! test/vader/plugin/**/*.vim'
    ```
* run tests using following command (assuming `:pwd` is `~/.config/nvim`):
    ```
    :Vader test/tests/**/*
    ```
