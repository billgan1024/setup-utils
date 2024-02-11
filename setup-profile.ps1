$out = "C:/Users/$env:USERNAME/Documents/PowerShell/Profile.ps1"
New-Item $out
Copy-Item profile.ps1 $out

Add-Content -Path $out -Value (Get-Content .\default_params.ps1)
Add-Content -Path $out -Value (Get-Content get.ps1)

cp .\PSScriptAnalyzerSettings.psd1 "C:/Users/$env:USERNAME/Documents/PowerShell/PSScriptAnalyzerSettings.psd1"

