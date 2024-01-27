oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_lean.omp.json" | Invoke-Expression
Set-PSReadLineOption -PredictionSource None
Import-Module posh-git

# git-update for "git add ., git commit -m ., git push"
function gupd {
    git add .
    git commit -m "."
    git push
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
