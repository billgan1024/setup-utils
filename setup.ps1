# run as admin with same working directory
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}

# https://stackoverflow.com/questions/6016436/in-powershell-how-do-i-define-a-function-in-a-file-and-call-it-from-the-powersh
. ./helper.ps1

cp .vimrc ~/.vimrc

# windows 10 context menu
reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

./install.ps1

./fonts.ps1


$pwsh = "C:/Users/pblpbl/Documents/PowerShell/Microsoft.PowerShell_profile.ps1"
new-item $pwsh -force
cp profile.ps1 $pwsh