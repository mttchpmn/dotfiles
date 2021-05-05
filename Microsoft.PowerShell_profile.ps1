Import-Module -Name posh-git

# Custom Prompt ----------------------------------------------------
function prompt {
    $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = [Security.Principal.WindowsPrincipal] $identity
    $adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator
    $isAdmin = $principal.IsInRole($adminRole)
    $cwd = $($(Get-Location) -replace ($env:USERPROFILE).Replace("\", "\\"), "~")

    $(if ($isAdmin) { Write-Host "[ADMIN]" -NoNewline - -ForegroundColor Red })
    
    Write-Host "[" -NoNewline
    Write-Host "$(Get-Date -Format "HH:mm")" -NoNewline -ForegroundColor DarkGreen
    Write-Host "]" -NoNewline
    Write-Host " " -NoNewline

    Write-Host "$env:USERNAME" -NoNewline -ForegroundColor DarkCyan
    Write-Host "@" -NoNewline
    Write-Host "$env:COMPUTERNAME" -NoNewline -ForegroundColor Magenta
    Write-Host ": " -NoNewline

    Write-Host "$cwd" -ForegroundColor Yellow

    # Git prompt settings
    $GitPromptSettings.BeforeStatus = "("
    $GitPromptSettings.AfterStatus = ") "
    Write-VcsStatus

    Write-Host "λ" -NoNewline

    return " "
}

# Common aliases ----------------------------------------------------

Set-Alias -Name c -Value Clear-Host
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name man -Value Get-Help

# Git Commands and aliases ----------------------------------------------------

function git-clone {
    $name=$args[0]
    $repo=$args[1]
    git clone "git@github.com:$name/$repo.git"
}
Set-Alias -Name gcl -Value git-clone

function git-checkout {
    git checkout $args
}
Set-Alias -Name gco -Value git-checkout

function git-create-branch {
    git checkout -b $args
}
Set-Alias -Name gcb -Value git-create-branch

function git-status {
    git status $args
}
Set-Alias -Name gs -Value git-status

function git-diff {
    git diff $args
}
Set-Alias -Name gd -Value git-diff

function git-add {
    git add $args
}
Set-Alias -Name ga -Value git-add

function git-commit {
    git commit -m $args
}
Set-Alias -Name gct -Value git-commit
