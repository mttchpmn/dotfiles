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

if [ -f ~/.work.sh ]; then
  source ~/.work.sh
fi

# Set default editor
export EDITOR=nvim

##################################################
# PATH

# Dotnet
export PATH=$PATH:$HOME/dotnet:$HOME/.dotnet/tools
export DOTNET_ROOT=$HOME/dotnet

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
alias bashrc='nvim ~/.bashrc'                
alias vimrc='nvim ~/.vimrc'
alias h='history'
alias c='clear'
alias r='reset'
alias x='exit'
alias la='ls -a'
alias ll='ls -FGalh --color=auto'
alias ts='tree -CshF -L 3'
alias duh='du -h --max-depth=1'
alias dfh='df -h'
alias cp='cp -v'
alias rm='rm -i'
alias cgrep='grep -Hn --color=always'
alias shutdown='shutdown -h now'

n() {
  if [[ -z $1 ]]; then
    nvim .
  else
    nvim $1
  fi
}

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
alias gc='git commit -m'
alias gl="git log --pretty=format:'%C(yellow)%h %Cred%ad %Cblue%an%Cgreen%d %Creset%s' --date=short"
alias gco='git checkout $1'
alias gcb='git checkout -b $1'
alias gpu='git push'
alias gpd='git pull'
alias grm='git restore --staged'

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

# Colors
YELLOW="\[\e[0;33m\]"
GREEN="\[\e[0;32m\]"
LGREEN="\[\e[1;32m\]"
PURPLE="\[\e[0;35m\]"
BLUE="\[\e[0;34m\]"
CYAN="\[\e[0;36m\]"
WHITE="\[\e[0;37m\]"
BLACK="\[\e[0;30m\]"
BG_WHITE="\[\e[0;47m\]"
COLOR_RESET="\[\e[0m\]" # Reset colors

# Text
ITALIC="\e[3m"
BOLD="\e[1m"
DIM="\e[2m"
BLINK="\e[5m"
TEXT_RESET="\e(B\e[m"

# Reset all
RESET="$TEXT_RESET$COLOR_RESET"


# Git prompt setup
GIT_PS1_SHOWDIRTYSTATE="true"
#GIT_PS1_SHOWUNTRACKEDFILES="true"
#GIT_PS1_SHOWUPSTREAM="auto"
#GIT_PS1_STATESEPARATOR="  "

TIME="$GREEN\t$RESET"
USER="$CYAN$ITALIC\u$RESET"
HOST="$PURPLE$BOLD\h$RESET"
DIR="$YELLOW$BOLD\w$RESET"
GIT="$LGREEN\$(__git_ps1)$RESET"

function lastCmd() {
  if [[ "$?" -ne "0" ]]; then
    echo -e "✘"
  else
    echo -e "✔"
  fi
}

# Define custom prompt
export PS1="┌[$TIME]──[$USER@$HOST]──┤ $DIR ├──[\$(lastCmd)]$GIT\n>$RESET "

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# tabtab source for packages
# uninstall by removing these lines
[ -f ~/.config/tabtab/__tabtab.bash ] && . ~/.config/tabtab/__tabtab.bash || true
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
