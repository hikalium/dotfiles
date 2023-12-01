#!/bin/bash -ex
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
source ~/.bashrc || true
./link.sh
./scripts/setup_nvim_linux_postinstall.sh
./scripts/install_github_cli.sh
gh auth status || { gh auth login && gh auth status ; }
git -C ~/dotfiles remote -v | grep https \
	&& git -C ~/dotfiles remote set-url origin git@github.com:hikalium/dotfiles.git \
	|| echo "dotfiles remote url is already using ssh"

echo "Done!"
