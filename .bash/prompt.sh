# COLOR ALIASES
COL_RED="\033[0;31m"
COL_YELLOW="\033[0;33m"
COL_GREEN="\033[0;32m"
COL_LGREEN="\033[1;32m"
COL_PURPLE="\033[0;35m"
COL_BLUE="\033[0;34m"
COL_CYAN="\033[0;36m"
COL_WHITE="\033[0;37m"
COL_BLACK="\033[0;30m"

BG_WHITE="\033[0;47m"

RS="\033[0m"

# GIT PROMPT SETUP
GIT_PS1_SHOWDIRTYSTATE="true"
#GIT_PS1_SHOWUNTRACKEDFILES="true"
#GIT_PS1_SHOWUPSTREAM="auto"
#GIT_PS1_STATESEPARATOR="  "

# Needed on OSX - works fine on Ubuntu
source /usr/local/Cellar/git/2.16.2/etc/bash_completion.d/git-prompt.sh

# PROMPT DEFINITION
export PS1="\[$COL_LGREEN\]\A\[$RS\] \[$COL_CYAN\]\u\[$RS\]@\[$RS\]\[$COL_PURPLE\]\h\[$RS\]:[\[$COL_YELLOW\]\w\[$RS\]]:\[$COL_LGREEN\]\$(__git_ps1)\[$RS\] "
