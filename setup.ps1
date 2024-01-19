# run as admin with same working directory
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}

cp .vimrc ~/.vimrc

function get {
    param (
        [string]$url,
        [string]$out
    )
    # if out is not specified, use the filename from the url
    if (!$out) {
        $out = $url.Split("/")[-1]
    }
    invoke-webrequest -uri $url -outfile $out
    start-process -filepath $out -wait
}

# windows 10 context menu
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

# Example usage
get "https://github.com/PowerShell/PowerShell/releases/download/v7.4.1/PowerShell-7.4.1-win-x64.msi"
get "https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user" vscode.exe
get "https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/Git-2.43.0-64-bit.exe"
get "https://aka.ms/vs/17/release/vs_BuildTools.exe"
get "https://downloader.battle.net/download/getInstallerForGame?os=win&gameProgram=OVERWATCH&version=Live&id=775f3e8b-f0b8-43d3-9610-69849a9a0076" overwatch.exe

get "https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip"
get "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip"
get "https://discord.com/api/downloads/distributions/app/installers/latest?channel=stable&platform=win&arch=x86" discord.exe

expand-archive -path JetBrainsMono-2.304.zip 
expand-archive -path FiraCode.zip

set-executionpolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
powershellget\install-module posh-git -Scope CurrentUser -Force

$pwsh = "C:/Users/pblpbl/Documents/PowerShell/Microsoft.PowerShell_profile.ps1"
new-item $pwsh -force
cp profile.ps1 $pwsh


# find ttf files in the current directory and install them
$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)

$here = $MyInvocation.PSScriptRoot


$font_files = Get-ChildItem -Path $here -Recurse | Where-Object {
    # $true
    (-not ($_.Name.Contains("["))) -and ($_.Name -ilike "JetBrainsMono-*.ttf" -or $_.Name -ilike "FiraCodeNerdFont-*.ttf")
}

foreach ($f in $font_files) {
    write-output $f.Name
    # $fname = $f.Name
    # write-host -ForegroundColor Green "installing {0}" -f $f.Name
    # $fonts.CopyHere($f.FullName)
}

Install-Module -Name PSScriptAnalyzer -RequiredVersion 1.20.0