cd `dirname $0`

pwd=`pwd`
echo $pwd/.vim

ln -snf $pwd/.vimrc ../.vimrc
ln -snf $pwd/.bashrc ../.bashrc
ln -snf $pwd/.bash_profile ../.bash_profile
ln -snf $pwd/.tmux.conf ../.tmux.conf
ln -snf $pwd/.vim/ftdetect/binary.vim ../.vim/ftdetect/binary.vim
