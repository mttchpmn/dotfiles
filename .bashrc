#  mttchpmn  _               _
#          | |__   __ _ ___| |__  _ __ ___
#          | '_ \ / _` / __| '_ \| '__/ __|
#         _| |_) | (_| \__ \ | | | | | (__
#        (_)_.__/ \__,_|___/_| |_|_|  \___|
#

##################################################
# DEFAULTS

if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

if [ -f ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
fi

if [ -f ~/.clubware.sh ]; then
  source ~/.clubware.sh
fi

# Set default editor
export EDITOR=vim

##################################################
# HISTORY

export HISTSIZE=1000000
export HISTFILESIZE=100000000
export HISTTIMEFORMAT="[%h %d %H:%M:%S] "
#export HISTCONTROL=ignoreboth:erasedups
#export HISTIGNORE="ls:ll:cd*:gs:gd:gdf:gc:gco:gcb:git*:c:r:history"

##################################################
# ALIASES AND FUNCTIONS

# Utility
alias h='history'
alias c='clear'
alias r='reset'
alias x='exit'
alias la='ls -a'
alias ll='ls -FGalh'
alias duh='du -h --max-depth=1'
alias dfh='df -h'
alias cp='cp -v'
alias rm='rm -i'
alias ts='tree -CshF -L 3'
alias cgrep='grep -Hn --color=always'

listport() {
        lsof -i :$1
}

killport() {
        kill $(lsof -t -i :$1)
}


# Git
alias gs='git status'
alias ga='git add'
alias gap='git add -p'
alias gd='git diff --color-moved'
alias gdc='git diff --compact-summary'
alias gdf='git diff --color | diff-so-fancy' # npm install -g diff-so-fancy
alias gc='git commit -m'
alias gl='git log'
alias gco='git checkout $1'
alias gcb='git checkout -b $1'
alias gps='git push'
alias gpl='git pull'
alias unstage='git restore --staged'

gclone() {
  git clone git@github.com:$1/$2.git $3
}

# Tmux
alias tls='tmux ls'
alias tns='tmux new -s $1'
alias tas='tmux attach-session -t $1'
alias tks='tmux kill-session -t $1'
alias tka='tmux kill-session -a'

##################################################
# SHELL PROMPT

# Color aliases
COL_YELLOW="\033[0;33m"
COL_GREEN="\033[0;32m"
COL_LGREEN="\033[1;32m"
COL_PURPLE="\033[0;35m"
COL_BLUE="\033[0;34m"
COL_CYAN="\033[0;36m"
COL_WHITE="\033[0;37m"
COL_BLACK="\033[0;30m"

BG_WHITE="\033[0;47m"

RS="\033[0m" # Reset colors

# Git prompt setup
GIT_PS1_SHOWDIRTYSTATE="true"
#GIT_PS1_SHOWUNTRACKEDFILES="true"
#GIT_PS1_SHOWUPSTREAM="auto"
#GIT_PS1_STATESEPARATOR="  "

TIME="\[$COL_LGREEN\]\A\[$RS\]"
USER="\[$COL_CYAN\]\u\[$RS\]"
HOST="\[$COL_PURPLE\]\h\[$RS\]"
DIR="\[$COL_YELLOW\]\w\[$RS\]"
GIT="\[$COL_LGREEN\]\$(__git_ps1)\[$RS\]"
NEWLINE="\\n\[$COL_PURPLE\]$\[$RS\] "

# Define custom prompt
export PS1="$TIME $USER@$HOST:[$DIR]$GIT $NEWLINE"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.bash ] && . ~/.config/tabtab/__tabtab.bash || true
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
