#!/bin/bash -e
if ! ~/bin/nvim.appimage --version ; then
	cd ~
	mkdir -p bin
	cd bin
	wget -N https://github.com/neovim/neovim/releases/download/v0.9.0/nvim.appimage
	export NVIM=`readlink -f ./nvim.appimage`
	chmod u+x ${NVIM}
	${NVIM} --version
fi
cat ~/.bashrc | grep -E '^alias vi=' || echo "alias vi=${NVIM}" >> ~/.bashrc
cat ~/.bashrc | grep -E '^alias vim=' || echo "alias vim=${NVIM}" >> ~/.bashrc
cat ~/.bashrc | grep -E '^alias nvim=' || echo "alias nvim=${NVIM}" >> ~/.bashrc
