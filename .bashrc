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

# Load Wherewolf settings
source ~/.bash/wherewolf.sh

# Load windows-specific and docker config
source ~/.bash/windows.sh

# Make sure we start in our home dir (necessary in WSL)
cd ~/

# Set default editor
export EDITOR=vim
