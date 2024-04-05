#!/bin/bash -ex
NVIM_VERSION=v0.9.5
if nvim --version | grep "NVIM ${NVIM_VERSION}" ; then
	echo "Neovim ${NVIM_VERSION} is already installed"
	export NVIM=`which nvim`
	cat ~/.bashrc | grep -E '^alias vi=' || echo "alias vi=${NVIM}" >> ~/.bashrc
	cat ~/.bashrc | grep -E '^alias vim=' || echo "alias vim=${NVIM}" >> ~/.bashrc
	cat ~/.bashrc | grep -E '^alias nvim=' || echo "alias nvim=${NVIM}" >> ~/.bashrc
else
	cd ~
	mkdir -p bin
	cd bin
	wget -N https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim.appimage
	export NVIM=`readlink -f nvim.appimage`
	chmod u+x ${NVIM}
	${NVIM} --version
	export NVIM=`readlink -f ./nvim.appimage`
	cat ~/.bashrc | grep -E '^alias vi=' || echo "alias vi=${NVIM}" >> ~/.bashrc
	cat ~/.bashrc | grep -E '^alias vim=' || echo "alias vim=${NVIM}" >> ~/.bashrc
	cat ~/.bashrc | grep -E '^alias nvim=' || echo "alias nvim=${NVIM}" >> ~/.bashrc
fi
