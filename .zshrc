#
# Matt's        _
#       _______| |__  _ __ ___
#      |_  / __| '_ \| '__/ __|
#     _ / /\__ \ | | | | | (__
#    (_)___|___/_| |_|_|  \___|
#
#############################################
# BASE SETUP
#############################################

# CHANGING SHELL TO ZSH:

# Install zsh with homebrew first
# `chsh -s `which zsh``

# If 'non-standard shell' error:
# sudo echo "$(which zsh)" >> /etc/shells

# If permission denied:
# sudo sh -c "echo $(which zsh) >> /etc/shells"

# Cause Nano is for bitch-ass niggas
export EDITOR=vim

#############################################
# PROMPT
#############################################

# If theme fucks out, uncomment this for a standard PS1 prompt
export PS1='%T  %F{cyan}%n%f@%F{magenta}%m%f:%F{green}%/%f >> '

#############################################
# FUNCTIONS
#############################################

# Launch a web server in current dir on specified port
function serve() { 
	python3 -m http.server $1
}

# Open file in sublime
function sub() {
  open -a Sublime\ Text $1
}

# Use pip globally and override need for acitvated virtualenv
function gpip() {
  PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

# Make ASCII text and pipe into clipboard
function ascii() {
  figlet -f big $* | pbcopy
}

# Create a quick note with specified filename
function note() {
  touch ~/notes/$1.txt
  vim ~/notes/$1.txt
}

# View file and pipe back into clipboard
function catcopy() {
  cat $1 | pbcopy
}

# Print from clipboard = Geek Points +1
function zprint() {
  lpr -P Wherewolf $1
}

# Save clipboard contents into editable file 
# of specified type
function clip() {
  pbpaste > ~/notes/clip.$1
  vim ~/notes/clip.$1
}

# Not for bewbs
function hide() {
  dir=$1
  chflags hidden $dir
  mv $dir $dir.noindex
}

function show() {
  dir=$1.noindex
  chflags nohidden $dir
  mv $dir $1
}


#############################################
# ALIASES
#############################################

alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

# Typing 5 letters is too slow bro
alias rs='reset'

# Matt used as Escape Rope - It's Super Effective!
alias x='exit'

# Git commands are too verbose
alias gs='git status'

alias ga='git add'

alias gd='git diff'

alias gc='git commit -m'

alias gps='git push'

alias gpl='git pull'

# Make me all pretty like
alias glog='git log --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'

# What's my IP address
alias ip='ifconfig en0 | grep -w inet'

# Cause fuck having no information
alias cp='cp -v'

# You're a fuckwit - here's a safety margin
alias rm='rm -i'

# NUKE IT OI
alias rmf='rm -rf'

# List me like one of your French girls
alias ls='ls -aFC'

# Cause finding shit is hard
alias grep='grep --color=auto'

# Edit this file quick, fool
alias zshrc='vim ~/.zshrc'

# Edit vimrc quick, fool
alias vimrc='vim ~/.vimrc'

# Reload this file quick, fool
alias srczsh='source ~/.zshrc'

# Also definitely not for bewbs
alias 4c='wget -H -A ".webm" -rc -Di.4cdn.org -P 4chan-pics -nd -erobots=off'

# Export Base64 to clipboard
alias b64='echo $1 | base64 | pbcopy'

#############################################
# WHEREWOLF SETTINGS
#############################################

# Set it up nigga
export WW_CODE_DIR=~/code
source $WW_CODE_DIR/helperscripts/bash/core
export PATH=$PATH:~/code/helperscripts
export PATH=$PATH:~/code/helperscripts/wolfplate

# ZSH Syntax Highlighting (This needs to be the last line)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh