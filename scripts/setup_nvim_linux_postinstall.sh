#!/bin/bash -ex
source ~/.bashrc || true
if ! nvm --version ; then
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
	export NVM_DIR="$HOME/.config/nvm"
	mkdir -p ${NVM_DIR}
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
	nvm install node
fi

~/bin/nvim.appimage --headless +PlugInstall +qall
~/bin/nvim.appimage --headless '+CocInstall coc-rust-analyzer' +qall
mkdir -p ~/dotfiles/log/
test -f ~/dotfiles/log/nvim_plug_status.txt && rm ~/dotfiles/log/nvim_plug_status.txt
~/bin/nvim.appimage --headless +PlugStatus '+w ~/dotfiles/log/nvim_plug_status.txt' +qa
cat ~/dotfiles/log/nvim_plug_status.txt
