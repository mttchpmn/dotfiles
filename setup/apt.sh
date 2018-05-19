# Update apt
sudo apt-get update

# Install base packages
sudo apt-get install -y git vim tmux tree grep htop openssh nodejs npm python python3

# Upgrade existing
sudo apt-get upgrade

# Fix any broken packages / missing dependencies
sudo apt-get install -f
