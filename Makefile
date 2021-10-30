# mttchpmn's Makefile

# Windows
windows: winget dotfiles

winget:
	@winget install Microsoft.WindowsTerminal.Preview
	@winget install Microsoft.Powershell
	@winget install Microsoft.VisualStudioCode
	@winget install Jetbrains.Rider.EAP
	@winget install BraveSoftware.BraveBrowser
	@winget install Insomnia.Insomnia
	@winget install Postman.Postman
	@winget install SlackTechnologies.Slack
	@winget install Notion.Notion
	@winget install Spotify.Spotify
	@winget install BlenderFoundation.Blender

# Linux
linux: alacritty rofi source snap pacman

snap:
	@snap install code --classic
	@snap install rider --classic
	@snap install slack --classic
	@snap install teams --classic
	@snap install spotify --classic

pacman:
	sudo pacman -S vim alacritty rofi ranger tree

dotnet:
	@snap install dotnet-sdk --classic

alacritty:
	@ln -sf $(PWD)/alacritty $(HOME)/.config

rofi:
	@ln -sf $(PWD)/rofi $(HOME)/.config

# Platform agnostic
dotfiles: bash vim tmux git 

folders:
	mkdir -p $(HOME)/code/work $(HOME)/code/personal

sdks: node dotnet

bash:
	@ln -sf $(PWD)/.bashrc $(HOME)
	@ln -sf $(PWD)/.bash_profile $(HOME)
	@ln -sf $(PWD)/.work.sh $(HOME)
	@ln -sf $(PWD)/.inputrc $(HOME)
	@source ~/.bashrc

vim:
	@ln -sf $(PWD)/.vimrc $(HOME)

tmux:
	@ln -sf $(PWD)/.tmux.conf $(HOME)

git:
	@ln -sf $(PWD)/git/.git-completion.bash $(HOME)/.git-completion.bash
	@ln -sf $(PWD)/git/.git-prompt.sh $(HOME)/.git-prompt.sh
	@ln -sf $(PWD)/git/.gitconfig $(HOME)/.gitconfig

node:
	@curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
	nvm install 14.15.5
	@npm install --global yarn typescript ts-node


.PHONY: all dotfiles sdks pacman snap bash vim tmux node dotnet alacritty rofi git linux windows
