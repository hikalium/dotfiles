#!/bin/bash -ex
NVIM_VERSION=v0.11.5
if nvim --version | grep "NVIM ${NVIM_VERSION}" || nvim --version | grep NVIM | grep dev ; then
	echo "$(nvim --version | grep NVIM) is installed"
	export NVIM=`which nvim`
	cat ~/.bashrc | grep -E '^alias vi=' || echo "alias vi=${NVIM}" >> ~/.bashrc
	cat ~/.bashrc | grep -E '^alias vim=' || echo "alias vim=${NVIM}" >> ~/.bashrc
	cat ~/.bashrc | grep -E '^alias nvim=' || echo "alias nvim=${NVIM}" >> ~/.bashrc
else
	cd ~
	mkdir -p bin
	cd bin
	wget -O nvim.appimage https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.appimage
	export NVIM=`readlink -f nvim.appimage`
	chmod u+x ${NVIM}
	${NVIM} --version
	export NVIM=`readlink -f ./nvim.appimage`
	cat ~/.bashrc | grep -E '^alias vi=' || echo "alias vi=${NVIM}" >> ~/.bashrc
	cat ~/.bashrc | grep -E '^alias vim=' || echo "alias vim=${NVIM}" >> ~/.bashrc
	cat ~/.bashrc | grep -E '^alias nvim=' || echo "alias nvim=${NVIM}" >> ~/.bashrc
fi
