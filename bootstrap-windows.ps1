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

function Open-WebDownloads([string] $configPath) {
	Write-Host -ForegroundColor Green "Opening web download links..."
	$config = Get-Content -Path $configPath | ConvertFrom-Json

	foreach ($url in $config.downloads) {
		Start-Process $url
	}

	Write-Host "Press [Enter] to continue, once downloads are installed."
	Read-Host
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
		winget search $package
	}
}

function Link-Files([string] $configPath) {
	Write-Host -ForegroundColor blue "Symlinking files to home directory..."
	$config = Get-Content -Path $configPath | ConvertFrom-Json

	foreach ($file in $config.files) {
		$source = $file.source
		$target = $file.target

		$link = "$HOME\$Target"
		$original = "$PSScriptRoot\$source"


		Write-Host "Symlinking $link to point to $source"

		New-Item -ItemType SymbolicLink -Force -Path $link -Target $original | Out-Null
	}
	Write-Host -ForegroundColor Green "Done."
}

function Main {
	$configPath = ".\windows\config.json"

	Write-Host -ForegroundColor Blue "Bootstrapping Windows machine..."

	# Install-Applications($configPath)
	# Open-WebDownloads($configPath)
	Link-Files($configPath)

	Write-Host -ForegroundColor Green "Bootstrapping complete. Have a nice day."
}
Main