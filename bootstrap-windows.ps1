#Requires -RunAsAdministrator

function Test-CommandExists([string] $commandName) {
	$ErrorActionPreference = 'stop'
	try {
		if (Get-Command $commandName) {
			return $true
		}
	}
	catch {
		return $false
	}
}

function Install-Packages([string] $configPath) {
	Write-Host "Installing packages from $configPath"

	$commandExists = Test-CommandExists("winget")
	while (-Not $commandExists) {
		Write-Host "WinGet not found. Please install WinGet and then press [Enter] to try again."
		Read-Host
		$commandExists = Test-CommandExists("winget")
	}

	$config = Get-Content -Path $configPath | ConvertFrom-Json

	# Write-Output $applications
	foreach ($package in $config.packages) {
		Write-Host ""
		Write-Host -ForegroundColor Green "Installing $package..."
		winget install $package | Out-Null
	}
}

function Open-WebDownloads([string] $configPath) {
	Write-Host -ForegroundColor Green "Opening web download links..."
	$config = Get-Content -Path $configPath | ConvertFrom-Json

	foreach ($url in $config.downloads) {
		Start-Process $url
	}

	Write-Host "Press [Enter] to continue, once downloads are installed."
	Read-Host
}

function Link-Files([string] $configPath) {
	Write-Host -ForegroundColor blue "Symlinking files to home directory..."
	$config = Get-Content -Path $configPath | ConvertFrom-Json

	foreach ($file in $config.files) {
		$source = $file.source
		$target = $file.target

		$link = "$HOME\$Target"
		$original = "$PSScriptRoot\$source"


		Write-Host "Symlinking $link to point to $original"

		New-Item -ItemType SymbolicLink -Force -Path $link -Target $original | Out-Null
	}
}

function Install-Custom-Modules([string] $configPath) {
	Write-Host -ForegroundColor blue "Install Powershell modules..."
	$config = Get-Content -Path $configPath | ConvertFrom-Json

	foreach ($module in $config.modules) {
		Write-Host -ForegroundColor Green "Installing module $module..."
		Install-Module -Force -AllowClobber $module
	}
}

function Run-Arbitrary-Commands([string] $configPath) {
	Write-Host -ForegroundColor blue "Running arbitrary commands..."
	$config = Get-Content -Path $configPath | ConvertFrom-Json

	foreach ($cmd in $config.commands) {
		Write-Host -ForegroundColor Green "Executing '$cmd'..."
		Invoke-Expression $cmd
	}
}

function Show-UI() {
	$shouldExit = $false

	while (-Not $shouldExit) {
		
		Clear-Host
		Write-Host -ForegroundColor Green "----------------| BOOTSTRAPPER |---------------"
		Write-Host ""

		Write-Host "Please select an action from the options below:"

		Write-Host "1) Install packages"
		Write-Host "2) Open web download links"
		Write-Host "3) Symlink dotfiles"
		Write-Host "4) Install PowerShell modules"
		Write-Host "5) Run arbitrary commands"
		Write-Host "6) Run all steps"
		Write-Host ""
		Write-Host "Q) Quit Bootstrapper"
		Write-Host "------------------------------------------------"

		$selection = Read-Host -Prompt ":"

		$configPath = "$PSScriptRoot\windows\config.json"
	
		Clear-Host

		switch ($selection) {
			"1" {
				Install-Packages($configPath)

				Write-Host ""
				Write-Host "------------------------------------------------"
				Write-Host -ForegroundColor Green "Done. Press any key to continue"
				Read-Host
			}
			"2" {
				Open-WebDownloads($configPath)

				Write-Host ""
				Write-Host "------------------------------------------------"
				Write-Host -ForegroundColor Green "Done. Press any key to continue"
				Read-Host
			}
			"3" {
				Link-Files($configPath)

				Write-Host ""
				Write-Host "------------------------------------------------"
				Write-Host -ForegroundColor Green "Done. Press any key to continue"
				Read-Host
			}
			"4" {
				Install-Custom-Modules($configPath)

				Write-Host ""
				Write-Host "------------------------------------------------"
				Write-Host -ForegroundColor Green "Done. Press any key to continue"
				Read-Host
			}
			"5" {
				Run-Arbitrary-Commands($configPath)

				Write-Host ""
				Write-Host "------------------------------------------------"
				Write-Host -ForegroundColor Green "Done. Press any key to continue"
				Read-Host
			}
			"6" {
				Install-Packages($configPath)
				Open-WebDownloads($configPath)
				Link-Files($configPath)
				Install-Custom-Modules($configPath)
				Run-Arbitrary-Commands($configPath)
				
				Write-Host ""
				Write-Host "------------------------------------------------"
				Write-Host -ForegroundColor Green "Bootstrapping complete. Have a nice day."
				$shouldExit = $true

			}
			"Q" {
				$shouldExit = $true
			}
			"q" {
				$shouldExit = $true
			}
			Default {
				Write-Host -ForegroundColor Red "Input not recognised. Exiting"
				$shouldExit = $true
			}
		}

	}
}

function Main {
	Show-UI
}
Main