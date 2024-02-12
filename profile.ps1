oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_lean.omp.json" | Invoke-Expression
Set-PSReadLineOption -PredictionSource None
Import-Module posh-git

# git-update for "git add ., git commit -m ., git push"
function gupd {
    # message parameter, default to "."
    param (
        # required parameter message
        [Parameter(Mandatory = $true)]
        [string]$message
    )
    git add .
    git commit -m "$message"
    git push
}

function gcl {
    # git clone recursive
    param (
        # required parameter message
        [Parameter(Mandatory = $true)]
        [string]$url
    )
    git clone --recursive $url
}

function gpristine {
    git reset --hard
    git clean -dffx
}

# function gcmsg {
#     git commit -m "."
# }
# cd code
# & "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Launch-VsDevShell.ps1" -SkipAutomaticLocation -Arch amd64


$GlobalPSScriptAnalyzerSettingsPath = "C:/Users/$env:USERNAME/Documents/PowerShell/PSScriptAnalyzerSettings.psd1"

# 
# New-Alias gn "git number"

function gn {
    git number $args
}
