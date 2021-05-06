Import-Module -Name posh-git

# Configure Vim Mode

Set-PSReadLineOption -EditMode Vi

# Change cursor for each Vim mode
function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    } else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

# Bind up arrow and K key (in CMD mode) to history search with current line contents
Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -ViMode Command -Chord k -Function HistorySearchBackward

# Map 'jj' to Esc
Set-PSReadLineKeyHandler -ViMode Insert -Chord j,j -Function ViCommandMode

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

# Pulls and rebases latest master from upstream and pushes to fork
function git-refresh {
    git pull --rebase upstream master
    git push origin master
}
Set-Alias -Name grf -Value git-refresh

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
