if (Get-Process -Name "YourProcessName" -ErrorAction SilentlyContinue) {
    Stop-Process -Name "AutoHotKey64" -Force
}
./control.ahk