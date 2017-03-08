cd `dirname $0`

pwd=`pwd`

wget -N https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
ln -snf $pwd/git-prompt.sh ../.git-prompt.sh

ln -snf $pwd/.vimrc ../.vimrc
ln -snf $pwd/.bashrc ../.bashrc
ln -snf $pwd/.bash_profile ../.bash_profile
ln -snf $pwd/.tmux.conf ../.tmux.conf

mkdir -p ../.vim/ftdetect
ln -snf $pwd/.vim/ftdetect/binary.vim ../.vim/ftdetect/binary.vim
