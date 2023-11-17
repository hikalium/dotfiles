#!/bin/bash -e
cd ~
echo "HOME dir: ${HOME}"
if [ -d dotfiles ] ; then
	echo "dotfiles is checked out already."
else
	echo "b"
fi
cd dotfiles
git pull --no-rebase
sudo apt install -y fuse wget build-essential tmux minicom
./scripts/setup_git.sh
./scripts/setup_nvim_linux.sh
source ~/.bashrc
./link.sh
./scripts/setup_nvim_linux_postinstall.sh

