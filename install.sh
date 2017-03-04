cd `dirname $0`

pwd=`pwd`

ln -snf $pwd/.vimrc ../.vimrc
ln -snf $pwd/.bashrc ../.bashrc
ln -snf $pwd/.bash_profile ../.bash_profile
ln -snf $pwd/.tmux.conf ../.tmux.conf

mkdir -p ../.vim/ftdetect
ln -snf $pwd/.vim/ftdetect/binary.vim ../.vim/ftdetect/binary.vim
