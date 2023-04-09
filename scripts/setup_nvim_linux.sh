#!/bin/bash
cd ~
mkdir -p bin
cd bin
wget -N https://github.com/neovim/neovim/releases/download/v0.9.0/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --version
cat ~/.bashrc | grep -E '^alias vim' || echo "alias vim=`readlink -f ~/nvim.appimage`" >> ~/.bashrc
cat ~/.bashrc | grep -E '^alias vi' || echo "alias vi=`readlink -f ~/nvim.appimage`" >> ~/.bashrc
cat ~/.bashrc | grep -E '^alias nvim' || echo "alias nvim=`readlink -f ~/nvim.appimage`" >> ~/.bashrc
