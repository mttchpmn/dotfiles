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

# Cause Nano is for bitch-ass niggas
export EDITOR=vim


#############################################
# ANTIGEN (Plugin and Theme Manager)
#############################################

# Note - Install Antigen using Homebrew

# Let's get this shit started fool
source /usr/local/share/antigen/antigen.zsh

# Load the oh-my-zsh plugin library
#antigen use oh-my-zsh

# Load the standard stuff from oh-my-zsh
antigen bundle robbyrussell/oh-my-zsh plugins/git
antigen bundle robbyrussell/oh-my-zsh plugins/tmux
antigen bundle robbyrussell/oh-my-zsh plugins/tmuxinator
antigen bundle dracula/zsh

# All the pretty colors (This must be the last bundle)
antigen bundle zsh-users/zsh-syntax-highlighting

# Theme it upppp
antigen theme agnoster
#antigen theme dracula

# ENGAGE!
antigen apply


#############################################
# POWERLINE
#############################################

# Required
#powerline-daemon -q

# Note - Powerline needs to be installed with Pip for it to work
# The package name is `powerline-status`
#. /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh

#############################################
# FUNCTIONS
#############################################

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

# Shutdown the computer
function nightnight() {
  sudo shutdown -h now
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

# Read a file out loud line by line
function readaloud() {
  while IFS='' read -r line || [[ -n "$line" ]]; do
    say "$line"
  done < "$1"
}

# Convert Markdown to faggotty JIRA textile, and save to clipboard
function jira() {
  cd ~/notes
  pandoc jira.md -f markdown -t textile -o jira.textile
  cat jira.textile | pbcopy
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

# There's no place like home
alias home='cd ~/'

# Typing 5 letters is too slow bro
alias cl='clear'

# Matt used as Escape Rope - It's Super Effective!
alias x='exit'

# Git commands are too verbose
alias gs='git status'

alias ga='git add'

alias gd='git diff'

alias gc='git commit -m'

alias gps='git push'

alias gpl='git pull'

# What's my IP address
alias ip='ifconfig en0 | grep -w inet'

# Cause fuck having no information
#alias cp='rsync -av'

# You're a fuckwit - here's a safety margin
alias rm='rm -i'

# List me like one of your French girls
alias ls='ls -aFC'

# Longer, but more memorable, yo
alias symlink='ln -s'

# Cause finding shit is hard
alias grep='grep --color=auto'

# Tmuxinator is a long-ass word
alias mux='tmuxinator'

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

# Make it quicker to edit app files
function editapp() {
  cd $WW_CODE_DIR/wherewolf-whitelabel/app
  vim -p resources/base/client-specific.css controllers/MasterController.js
}

# Streamline the app design process
function appdesign() {
  pool=$1
  echo POOL NAME: $pool
  echo 

  # Copy app start files, rename, and open dir in finder
  echo Copying base design folder ...
  cp ~/design/resources/BASE_1 ~/design
  sleep 1
  echo Renaming folder ...
  mv ~/design/BASE_1 ~/design/$pool
  cd ~/design/$pool
  sleep 1
  echo Opening folder ...
  open .
  read -rs '?Press a key to continue ...'
  echo

  # Switch to WL and checkout branch
  echo Switching to Whitelabel ...
  cd ~/code/wherewolf-whitelabel
  sleep 1
  echo Checking out branch: wherewolf-$pool
  git checkout wherewolf-$pool
  sleep 1
  echo Pulling from origin ...
  git pull origin wherewolf-$pool
  read -rs '?Press a key to continue ... '
  echo

  # Launch localhost in browser
  echo Launching local app environment ...
  echo Please start espresso server
  open http://localhost:8000/wherewolf
  read -rs '?Press a key to continue ... '
  echo

  # Open client-specific.css and MasterController.js for editing
  cd app
  echo Opening files for editing ...
  vim -p resources/base/client-specific.css controllers/MasterController.js

}
