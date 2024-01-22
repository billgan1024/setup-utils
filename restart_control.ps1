. ./default_params.ps1
if (Get-Process -Name "AutoHotKey64") {
    Stop-Process -Name "AutoHotKey64" -Force
}
./control.ahk