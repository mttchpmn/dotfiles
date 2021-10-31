Write-Host "Setting up Windows environment"...

Write-Host "Installing applications..."
winget install Microsoft.WindowsTerminal.Preview
winget install Microsoft.Powershell
winget install Microsoft.VisualStudioCode
winget install Jetbrains.Rider.EAP
winget install Jetbrains.WebStorm.EAP
winget install BraveSoftware.BraveBrowser
winget install Mozilla.Firefox
winget install Insomnia.Insomnia
winget install Postman.Postman
winget install SlackTechnologies.Slack
winget install Notion.Notion
winget install Spotify.Spotify --force
winget install BlenderFoundation.Blender

Write-Host "Installing packages..."
winget install Git.Git
winget install Vim.Vim
winget install Docker.DockerDesktop

Write-Host "Installing 'Oh My Posh' module..."
Install-Module oh-my-posh -Scope CurrentUser
Install-Module Terminal-Icons
Install-Module z -AllowClobber
Install-Module PSReadline -RequiredVersion 2.2.0-beta1 -AllowPrerelease

Write-Host "Opening admin shell..."
Start-Process powershell -Verb runas -ArgumentList '-noExit', '-File', 'C:\Users\matt\dotfiles\symlink.ps1'
