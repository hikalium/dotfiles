#!/bin/bash -e

cd `tmux display-message -p -F "#{pane_current_path}"`
source ~/.git-prompt.sh
__git_ps1 "(%s)"
