#!/bin/bash -eu
pwd=`pwd`

GITCOMPLURL=https://raw.githubusercontent.com/git/git/master/contrib/completion

if [ ! -d tmp ]; then
	mkdir tmp
fi

ln -snf $pwd ~/.dotfiles


if [ ! -f ~/.git-completion.bash ]; then
	wget -N $GITCOMPLURL/git-prompt.sh -P tmp/
	wget -N $GITCOMPLURL/git-completion.bash -P tmp/
	ln -snf $pwd/tmp/git-prompt.sh ~/.git-prompt.sh
	ln -snf $pwd/tmp/git-completion.bash ~/.git-completion.bash
fi

# .bash_profile
PATH_REAL_LOCAL_BASH_PROFILE=$pwd/hosts/bash_profile.`hostname`
if [ ! -f $PATH_REAL_LOCAL_BASH_PROFILE ]; then
	if [ ! -L ~/.bash_profile ] && [ -f ~/.bash_profile ]; then
		cp ~/.bash_profile $PATH_REAL_LOCAL_BASH_PROFILE
	else
		echo "source ~/.bashrc" > $PATH_REAL_LOCAL_BASH_PROFILE
	fi
fi
ln -snf $PATH_REAL_LOCAL_BASH_PROFILE ~/.bash_profile
ls -la ~/.bash_profile

# .bashrc and .bashrc.hostname
PATH_REAL_LOCAL_BASH_RC=$pwd/hosts/bashrc.`hostname`
if [ ! -f $PATH_REAL_LOCAL_BASH_RC ]; then
	if [ ! -L ~/.bashrc ] && [ -f ~/.bashrc ]; then
		cp ~/.bashrc $PATH_REAL_LOCAL_BASH_RC
	else
		echo 'source ~/.bashrc.common' > $PATH_REAL_LOCAL_BASH_RC
	fi
fi
ln -snf $pwd/bashrc ~/.bashrc.common
ls -la ~/.bashrc.common
ln -snf $PATH_REAL_LOCAL_BASH_RC ~/.bashrc
ls -la ~/.bashrc

ln -snf $pwd/.tmux.conf ~/.tmux.conf
ln -snf $pwd/.tmux.osx.conf ~/.tmux.osx.conf
ln -snf $pwd/.tmux.linux.conf ~/.tmux.linux.conf
ln -snf $pwd/screenrc ~/.screenrc

# nvim
PATH_REAL_LOCAL_NVIM_INIT=$pwd/hosts/init.vim.`hostname`
if [ ! -f $PATH_REAL_LOCAL_NVIM_INIT ]; then
	if [ -f ~/.config/nvim/init.vim ]; then
		cp ~/.config/nvim/init.vim $PATH_REAL_LOCAL_NVIM_INIT
	elif [ -f ~/.vimrc ]; then
		cp ~/.vimrc $PATH_REAL_LOCAL_NVIM_INIT
	else
		touch $PATH_REAL_LOCAL_NVIM_INIT
	fi
fi
mkdir -p ~/.config/nvim/
ln -snf $PATH_REAL_LOCAL_NVIM_INIT ~/.config/nvim/init.vim
ls -la ~/.config/nvim/init.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# vim
ln -snf $pwd/.vimrc ~/.vimrc
ls -la ~/.vimrc
mkdir -p ~/.vim/ftdetect
ln -snf $pwd/.vim/ftdetect/binary.vim ~/.vim/ftdetect/binary.vim
if [ ! -f ~/.vim/autoload/plug.vim ]; then
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

ln -snf $pwd/alacritty.yml ~/.alacritty.yml
ls -la ~/.alacritty.yml
