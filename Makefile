all: packages dotfiles sdks apps  

packages: pacman

dotfiles: bash vim tmux git alacritty rofi source

sdks: node dotnet

apps: snap

pacman:
	sudo pacman -S vim alacritty rofi ranger 

snap:
	@snap install code --classic
	@snap install rider --classic
	@snap install postman --classic
	@snap install dotnet-sdk --classic
	@snap install firefox --classic
	@snap install slack --classic
	@snap install teams --classic
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
	@ln -sf $(PWD)/git/.git-completion.bash $(HOME)
	@ln -sf $(PWD)/git/.git-prompt.sh $(HOME)
	@ln -sf $(PWD)/git/.gitconfig $(HOME)

node:
	@curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
	@npm install --global yarn typescript ts-node

dotnet:
	@snap install dotnet-sdk --classic

alacritty:
	@ln -sf $(PWD)/alacritty $(HOME)/.config

rofi:
	@ln -sf $(PWD)/rofi $(HOME)/.config

source: bash
	@source ~/.bashrc

.PHONY: all
