`dirname $0`

pwd=`pwd`

GITCOMPLURL=https://raw.githubusercontent.com/git/git/master/contrib/completion

mkdir tmp

wget -N $GITCOMPLURL/git-prompt.sh -P tmp/
wget -N $GITCOMPLURL/git-completion.bash -P tmp/
ln -snf $pwd/tmp/git-prompt.sh ~/.git-prompt.sh
ln -snf $pwd/tmp/git-completion.bash ~/.git-completion.bash

ln -snf $pwd/.vimrc ../.vimrc
ln -snf $pwd/.bashrc ../.bashrc
ln -snf $pwd/.bash_profile ../.bash_profile
ln -snf $pwd/.tmux.conf ../.tmux.conf
ln -snf $pwd/.tmux.osx.conf ../.tmux.osx.conf

mkdir -p ../.vim/ftdetect
ln -snf $pwd/.vim/ftdetect/binary.vim ../.vim/ftdetect/binary.vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
