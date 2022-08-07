# mttchpmn's Powershell Profile

# Module Imports ##########################################################

Import-Module -Name Terminal-Icons

if ($host.Name -eq 'ConsoleHost') {
    Import-Module PSReadLine
}

# Readline Options ########################################################

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Bind up arrow and K key (in CMD mode) to history search with current line contents
Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -ViMode Command -Chord k -Function HistorySearchBackward
# Change cursor according to Vim mode (block in Normal mode, bar in insert mode)
function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    }
    else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange


# Map 'jj' to Esc
Set-PSReadLineKeyHandler -Chord 'j' -ScriptBlock {
    if ([Microsoft.PowerShell.PSConsoleReadLine]::InViInsertMode()) {
        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        if ($key.Character -eq 'k') {
            [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
        }
        else {
            [Microsoft.Powershell.PSConsoleReadLine]::Insert('j')
            [Microsoft.Powershell.PSConsoleReadLine]::Insert($key.Character)
        }
    }
}
# Custom Prompt ----------------------------------------------------

# Note - not currently using in favor of oh-my-posh
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

# Need to also install Nerdfont and set terminal / vscode to use nerd font
Set-PoshPrompt -Theme jandedobbeleer

# Aliases ###################################################################

Set-Alias -Name c -Value Clear-Host
Set-Alias -Name ll -Value Get-ChildItem
Set-Alias -Name man -Value Get-Help
Set-Alias -Name vim -Value "C:\Program Files\Vim\vim82\vim.exe"

# Functions ################################################################

function symlink {
    $source = $args[0]
    $dest = $args[1]

    New-Item -ItemType SymbolicLink -Path $dest -Target $source
}

# Git Commands and aliases ----------------------------------------------------

function open-lazygit {
    lazygit.exe
}

Set-Alias -Name lg -Value open-lazygit
function git-clone {
    $name = $args[0]
    $repo = $args[1]
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
function git-commit-faml {
    $hasTicket = $(git rev-parse --abbrev-ref HEAD) -match "PFM-\d{4}"

    if (!$hasTicket) {
        echo "Error: No FirstAML ticket ID found in branch name"
        return
    }

    $ticket = $Matches[0]
    $message = $args[0]

    git commit -m "[$ticket] $message"
}
Set-Alias -Name gcf -Value git-commit-faml

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
