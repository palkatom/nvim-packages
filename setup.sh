config_dir=~/.config/nvim

pkexec bash << EOF
apt-add-repository ppa:neovim-ppa/unstable
apt update -y
apt install -y git fonts-firacode neovim-qt
EOF

mkdir -p $config_dir
cd $config_dir
git clone --branch master --recurse-submodules https://github.com/palkatom/nvim-packages .

python3 -m pip install virtualenv
python3 -m virtualenv $config_dir/pyenv/py3nvim
python3 -m virtualenv -p python2 $config_dir/pyenv/py2nvim
source $config_dir/pyenv/py3nvim/bin/activate
pip install pynvim
source $config_dir/pyenv/py2nvim/bin/activate
pip install pynvim
deactivate
