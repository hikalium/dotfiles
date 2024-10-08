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

export NVIM=`alias nvim | cut -d '=' -f 2 | sed -e "s/^'//" -e "s/'$//" || which nvim`
[ "${NVIM}" != "" ] || { echo "FAIL: nvim not found" ; exit 1 ; }
[ -f ${NVIM} ] || { echo "FAIL: nvim not found" ; exit 1 ; }
echo "NVIM is at: ${NVIM}"

${NVIM} --headless +PlugInstall +qall
${NVIM} --headless '+CocInstall coc-rust-analyzer' +qall
${NVIM} --headless '+CocInstall coc-json' +qall
mkdir -p ~/.config/nvim
ln -snf ~/dotfiles/common/coc-settings.json ~/.config/nvim/coc-settings.json
mkdir -p ~/dotfiles/log/
test -f ~/dotfiles/log/nvim_plug_status.txt && rm ~/dotfiles/log/nvim_plug_status.txt
${NVIM} --headless +PlugStatus '+w ~/dotfiles/log/nvim_plug_status.txt' +qa
cat ~/dotfiles/log/nvim_plug_status.txt
