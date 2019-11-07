Documentation generated with Jupyter and Calysto Bash kernel

# Install dependencies

This is to make sure that all needed dependencies are present. Script tested on Ubuntu 19.10.

## Dependencies

* `git`
* `fonts-firacode` (font)

### Assumptions

* `pkexec` is available to authenticate user (for administrative tasks). It is available in Ubuntu 19.10.

### Tips && tricks

We pass multiple commands through bash's here document to avoid multiple password asks (one for each `pkexec` execution).

# Install daily Neovim build

1. Add neovim unstable repository
2. Install neovim-qt (and latest neovim as dependency)


```bash
pkexec bash << EOF
apt-add-repository ppa:neovim-ppa/unstable
apt update -y
apt install -y git fonts-firacode neovim-qt
EOF
```

# Configure Neovim

Configuration using repository.


```bash
mkdir -p ~/.config/nvim
cd ~/.config/nvim
git clone --branch master --recurse-submodules https://github.com/palkatom/nvim-packages .
```

# Configure additional dependencies

## Python neovim client


```bash
python3 -m pip install virtualenv
python3 -m virtualenv ~/.config/nvim/pyenv/py3nvim
python3 -m virtualenv -p python2 ~/.config/nvim/pyenv/py2nvim
source ~/.config/nvim/pyenv/py3nvim/bin/activate
pip install pynvim
source ~/.config/nvim/pyenv/py2nvim/bin/activate
pip install pynvim
deactivate
```
