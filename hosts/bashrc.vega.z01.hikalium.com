source ~/.bashrc.common
alias vi=/home/hikalium/bin/nvim.appimage
alias vim=/home/hikalium/bin/nvim.appimage
alias nvim=/home/hikalium/bin/nvim.appimage

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
