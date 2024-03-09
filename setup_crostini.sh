#!/bin/bash -ex
cd ~
echo "HOME dir: ${HOME}"
if [ -d dotfiles ] ; then
	echo "dotfiles is checked out already."
else
	git clone https://github.com/hikalium/dotfiles.git
fi
cd dotfiles
git pull --no-rebase https://github.com/hikalium/dotfiles.git
sudo apt update
sudo apt install -y fuse wget build-essential tmux minicom
./scripts/setup_git.sh
./scripts/setup_nvim_linux.sh
source ~/.bashrc || true
./link.sh
./scripts/setup_nvim_linux_postinstall.sh
./scripts/install_github_cli.sh
./scripts/install_rust_analyzer.sh
gh auth status || { gh auth login && gh auth status ; }
git -C ~/dotfiles remote -v | grep https \
	&& git -C ~/dotfiles remote set-url origin git@github.com:hikalium/dotfiles.git \
	|| echo "dotfiles remote url is already using ssh"

if [ -d ~/.ssh ] && [ -f ~/.ssh/id_ed25519.pub ] ; then
	echo "id_ed25519.pub already exists"
else
	ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519
	cat ~/.ssh/id_ed25519.pub
	echo "https://github.com/settings/ssh/new"
fi

echo "Done!"
