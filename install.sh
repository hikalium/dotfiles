#!/bin/bash -eu
echo "pwd: `dirname $0`"

pwd=`pwd`

GITCOMPLURL=https://raw.githubusercontent.com/git/git/master/contrib/completion

if [ ! -d tmp ]; then
	mkdir tmp
fi


if [ ! -f ~/.git-completion.bash ]; then
	wget -N $GITCOMPLURL/git-prompt.sh -P tmp/
	wget -N $GITCOMPLURL/git-completion.bash -P tmp/
	ln -snf $pwd/tmp/git-prompt.sh ~/.git-prompt.sh
	ln -snf $pwd/tmp/git-completion.bash ~/.git-completion.bash
fi

ln -snf $pwd/.vimrc ../.vimrc

# .bash_profile
PATH_REAL_LOCAL_BASH_PROFILE=~/dotfiles/hosts/bash_profile.`hostname`
if [ ! -f $PATH_REAL_LOCAL_BASH_PROFILE ]; then
	if [ ! -L ~/.bash_profile ]; then
		cp ~/.bash_profile $PATH_REAL_LOCAL_BASH_PROFILE
	else
		echo "source ~/.bashrc" > $PATH_REAL_LOCAL_BASH_PROFILE
	fi
fi
ln -snf $PATH_REAL_LOCAL_BASH_PROFILE ~/.bash_profile
ls -la ~/.bash_profile

# .bashrc and .bashrc.hostname
PATH_REAL_LOCAL_BASH_RC=~/dotfiles/hosts/bashrc.`hostname`
if [ ! -f $PATH_REAL_LOCAL_BASH_RC ]; then
	if [ ! -L ~/.bashrc ]; then
		cp ~/.bashrc $PATH_REAL_LOCAL_BASH_RC
	else
		echo "# Local bash rc" > $PATH_REAL_LOCAL_BASH_RC
	fi
fi
ln -snf $pwd/.bashrc ../.bashrc
ls -la ~/.bashrc
ls -la $PATH_REAL_LOCAL_BASH_RC

ln -snf $pwd/.tmux.conf ../.tmux.conf
ln -snf $pwd/.tmux.osx.conf ../.tmux.osx.conf

mkdir -p ../.vim/ftdetect
ln -snf $pwd/.vim/ftdetect/binary.vim ../.vim/ftdetect/binary.vim

if [ ! -f ~/.vim/autoload/plug.vim ]; then
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "done."
