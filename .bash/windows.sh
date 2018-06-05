# DOCKER SETUP

# Add Docker executables to path
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="$PATH:/mnt/c/Program\ Files/Docker/Docker/resources/bin"

# Alias Windows Docker command so WSL Docker behaves like native Docker
alias docker=docker.exe
alias docker-compose=docker-compose.exe

# WINDOWS SPECIFIC SETUP

# Alias C:/ home dir
alias c='/mnt/c/Users/mttchpmn'

# Mimic native Linux commands
alias shutdown='/mnt/c/Windows/System32/shutdown.exe /s'
alias reboot='/mnt/c/Windows/System32/shutdown.exe /r'

# Be able to call CMD commands within Hyper
alias cmd='/mnt/c/Windows/System32/cmd.exe /c'

# Open Windows files and programs from WSL Bash
alias open='/mnt/c/Windows/System32/cmd.exe /c start'