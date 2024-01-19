
# run as admin with same working directory
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"cd '$pwd'; & '$PSCommandPath';`"";
    exit;
}

# https://stackoverflow.com/questions/6016436/in-powershell-how-do-i-define-a-function-in-a-file-and-call-it-from-the-powersh
# Read-Host -Prompt "press any key to continue"
. ./helper.ps1


./fonts.ps1


Install-Module -Name PSScriptAnalyzer -RequiredVersion 1.20.0