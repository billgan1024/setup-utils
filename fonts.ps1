. ./helper.ps1
get "https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip"
get "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip"
Expand-Archive -Path JetBrainsMono-2.304.zip  -Force
Expand-Archive -Path FiraCode.zip -Force


# find ttf files in the current directory and install them
$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)

$font_files = Get-ChildItem -Path "." -Recurse | Where-Object {
    # $true
    (-not ($_.Name.Contains("["))) -and ($_.Name -ilike "JetBrainsMono-*.ttf" -or $_.Name -ilike "FiraCodeNerdFont-*.ttf")
}

foreach ($f in $font_files) {
    # write-output $f.Name
    $fname = $f.Name
    Write-Host -ForegroundColor Green "installing $fname..."
    $fonts.CopyHere($f.FullName)
}
