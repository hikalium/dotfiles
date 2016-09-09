
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# enable color support of ls and also add handy aliases
 if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors     -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi


# nodejs
nvm_path=~/.nvm/nvm.sh
if [ -e $nvm_path ]; then
	echo "nodejs installed."
	source ~/.nvm/nvm.sh
	nvm use v6.4.0
fi

# prolog
swipl_path=/Applications/SWI-Prolog.app/Contents/MacOS
if [ -e $swipl_path ]; then
	echo "swi-prolog installed."
	PATH="$PATH":$swipl_path
fi

# export env
export EDITOR=vim

# set prompt
RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
CYAN="\[\033[0;36m\]"
RESET="\[\033[0m\]"

if [ -n "$SSH_CLIENT" ]; then
	isssh="${RED}[ssh]${RESET}"
else
	isssh="${GREEN}[local]${RESET}"
fi
export PS1="${isssh} \u@\H: ${CYAN}\w${RESET}\n\$ "
