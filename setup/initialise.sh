#!/usr/bin/env bash
echo "Initialising new set up..."
echo "Running apt.sh..."
bash apt.sh

echo "Running git.sh..."
bash git.sh

echo "Running npm.sh..."
bash npm.sh

echo "Symlinking dotfiles"
ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/.bash ~/.bash

ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.vim/.vimrc ~/.vimrc