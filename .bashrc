#######################################################################################
#                                                                                     #
#                             mttchpmn - .bashrc                                      #
#                                                                                     #
#######################################################################################

# Load Ubuntu defaults
source ~/.bash/ubuntu_base.sh

# Load aliases
source ~/.bash/bash_aliases

# Load PS1 prompt
source ~/.bash/prompt.sh

# Load windows-specific and docker config
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    source ~/.bash/windows.sh
fi

# Make sure we start in our home dir (necessary in WSL)
cd ~/

# Set default editor
export EDITOR=vim
