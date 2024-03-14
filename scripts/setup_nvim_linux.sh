#!/bin/bash -e
NVIM_VERSION=v0.9.5
if ! ~/bin/nvim.appimage --version | grep "NVIM ${NVIM_VERSION}" ; then
	cd ~
	mkdir -p bin
	cd bin
	wget -N https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim.appimage
	chmod u+x ${NVIM}
	${NVIM} --version
fi
export NVIM=`readlink -f ./nvim.appimage`
cat ~/.bashrc | grep -E '^alias vi=' || echo "alias vi=${NVIM}" >> ~/.bashrc
cat ~/.bashrc | grep -E '^alias vim=' || echo "alias vim=${NVIM}" >> ~/.bashrc
cat ~/.bashrc | grep -E '^alias nvim=' || echo "alias nvim=${NVIM}" >> ~/.bashrc
