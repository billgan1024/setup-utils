oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\powerlevel10k_lean.omp.json" | Invoke-Expression
Set-PSReadLineOption -PredictionSource None
Import-Module posh-git
