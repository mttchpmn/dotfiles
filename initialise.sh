#!/usr/bin/env bash

setup_packages () {
    # Update apt
    sudo apt-get update

    # Install base packages
    sudo apt-get install -y git vim tmux tree grep htop openssh nodejs npm python python3 postgresql postgresql-contrib

    # Upgrade existing
    sudo apt-get upgrade

    # Fix any broken packages / missing dependencies
    sudo apt-get install -f
}

setup_git () {
    git config --global user.name "Matt Chapman"
    git config --global user.email "matt@mttchpmn.com"
    git config --global core.editor vim
    # Actually *run* the command if we mistype it (2 sec delay)
    git config --global help.autocorrect 20

    cd ~/
    git clone git@github.com:mttchpmn/dotfiles.git

    cd ~/
    mkdir code
    cd code

    # Wherewolf repositories
    git clone git@github.com:wherewolfnz/helperscripts.git
    git clone git@github.com:wherewolfnz/docker.git
    git clone git@github.com:wherewolfnz/frontend.git
    git clone git@github.com:wherewolfnz/wherewolf-backend.git
    git clone git@github.com:wherewolfnz/wherewolf-whitelabel.git
    git clone git@github.com:wherewolfnz/desmond.git

    # Personal Repositories
    git clone git@github.com:mttchpmn/MetScope.git
    git clone git@github.com:mttchpmn/metscope-frontend.git
}

setup_npm () {
    sudo npm install -g npm
    sudo npm install -g eslint nodemqon sails express ionic @angular/cli
}

setup_dotfiles () {
    ln -s ~/dotfiles/.bashrc ~/.bashrc
    ln -s ~/dotfiles/.bash ~/.bash

    ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
    ln -s ~/dotfiles/.vim/.vimrc ~/.vimrc

    source ~/.bashrc
}

checkThen () {
read -p "Press anything to continue or s to skip" ANS
if [[ $ANS != s ]]
then
    echo 'Proceeding...'
    $($1)
fi 
if [[ $ANS = s ]]
then
    echo 'Skipping...'
fi 
}

foo () {
    echo "Blah"
}

###################################################################################

echo "Initialising new system setup"

echo "Setting up system packages"
checkThen setup_packages

echo "Setting up Git"
checkThen setup_git

echo "Setting up NPM"
checkThen setup_npm

echo "Setting up dotfiles"
checkThen setup_dotfiles

echo "All done - enjoy!"
