#!/bin/bash -ex
source ~/.bashrc || true
export NVM_DIR="$HOME/.config/nvm"
if ! nvm --version ; then
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
	mkdir -p ${NVM_DIR}
fi

[ -f "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -f "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if ! nvm version node ; then
	nvm install node
fi

export NVIM=`readlink -f ~/bin/nvim.appimage`
[ -f ${NVIM} ] || { echo "FAIL: nvim not found" ; exit 1 ; }
echo "NVIM is at: ${NVIM}"

${NVIM} --headless +PlugInstall +qall
${NVIM} --headless '+CocInstall coc-rust-analyzer' +qall
mkdir -p ~/dotfiles/log/
test -f ~/dotfiles/log/nvim_plug_status.txt && rm ~/dotfiles/log/nvim_plug_status.txt
${NVIM} --headless +PlugStatus '+w ~/dotfiles/log/nvim_plug_status.txt' +qa
cat ~/dotfiles/log/nvim_plug_status.txt
