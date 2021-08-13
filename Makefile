all: packages dotfiles sdks apps  

packages: pacman

dotfiles: bash vim tmux git alacritty rofi source

sdks: node dotnet

apps: snap

pacman:
	sudo pacman -S vim alacritty rofi ranger tree

snap:
	@snap install code --classic
	@snap install rider --classic
	@snap install slack --classic
	@snap install spotify --classic


bash:
	@ln -sf $(PWD)/.bashrc $(HOME)
	@ln -sf $(PWD)/.bash_profile $(HOME)
	@ln -sf $(PWD)/.work.sh $(HOME)
	@ln -sf $(PWD)/.inputrc $(HOME)

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

dotnet:
	@snap install dotnet-sdk --classic

alacritty:
	@ln -sf $(PWD)/alacritty $(HOME)/.config

rofi:
	@ln -sf $(PWD)/rofi $(HOME)/.config

folders:
	mkdir -p $(HOME)/code/work $(HOME)/code/personal

source: bash
	@source ~/.bashrc

.PHONY: all packages dotfiles sdks apps pacman snap bash vim tmux node dotnet alacritty rofi git
