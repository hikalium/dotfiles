source ~/.bashrc.common
eval $(/opt/homebrew/bin/brew shellenv)
export BASH_SILENCE_DEPRECATION_WARNING=1

