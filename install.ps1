# Example usage
get "https://github.com/PowerShell/PowerShell/releases/download/v7.4.1/PowerShell-7.4.1-win-x64.msi"
get "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user" vscode.exe
get "https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/Git-2.43.0-64-bit.exe"
get "https://aka.ms/vs/17/release/vs_BuildTools.exe"
get "https://downloader.battle.net/download/getInstallerForGame?os=win&gameProgram=OVERWATCH&version=Live&id=775f3e8b-f0b8-43d3-9610-69849a9a0076" overwatch.exe

get "https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x86" discord.exe

set-executionpolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
powershellget\install-module posh-git -Scope CurrentUser -Force
