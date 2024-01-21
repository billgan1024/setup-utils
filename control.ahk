g := Gui()
g.OnEvent("Close", close)
g.SetFont("s16")

g.AddText(, "ahk control panel")
; f1 := g.AddCheckbox("Checked", "F1 -> LButton")
g.AddText(, "click delay")
uhc := g.AddCheckbox("", "uhc mode")
combo_x := g.AddCheckbox("", "combo x")

click_delay := g.AddSlider("", 40)
click_delay.OnEvent("Change", click_changed)

g.Show()


; SetCapsLockState("AlwaysOff")

RShift & t::
{
    ; terminal/teams
    if WinExist("ahk_exe WindowsTerminal.exe") {
        WinActivate("ahk_exe WindowsTerminal.exe")
    } else if WinExist("ahk_exe teams.exe") {
        WinActivate("ahk_exe teams.exe")
    }
}

RShift & g::
{
    activate("ahk_exe mintty.exe")
}
; arrays are fucking 1-indexed
; and you need "global" for updating a global variable lmfao
code_list := WinGetList("ahk_exe Code.exe")

SetTimer(UpdateCodeList, 1000)


UpdateCodeList() {
    global code_list
    global code_index
    ; new_list tends to shuffle the order, so only assign to list if size changes
    new_list := WinGetList("ahk_exe Code.exe")
    if new_list.Length != code_list.Length {
        code_list := new_list
        if code_index > code_list.Length {
            code_index := 1
        }
    }
}

code_index := 1
RShift & c::
{
    ; ; focus code
    ; if WinExist("ahk_exe Code.exe") {
    ;     WinActivate("ahk_exe Code.exe")
    ; }
    ; WinGet, WinList, List, ahk_class PSDocC
    ; https://www.autohotkey.com/docs/v1/misc/WinTitle.htm#ahk_id
    code()
}

code() {
    if !WinExist("ahk_exe code.exe") {
        Run("code")
    }
    else {
        global code_index
        global code_list
        ; list := WinGetList("ahk_exe Code.exe")
        if !WinActive("ahk_exe Code.exe") {
            ; MsgBox(list[code_index])
            WinActivate("ahk_id " code_list[code_index])
        } else {
            code_index++
            if code_index == code_list.Length + 1 {
                code_index := 1
            }
            WinActivate("ahk_id " code_list[code_index])
        }
    }

}

RShift & e::
{
    activate("ahk_exe vivaldi.exe")
}




activate(winTitle) {
    if WinExist(winTitle) {
        WinActivate(winTitle)
    }
}


explorer_index := 1
explorer_list := WinGetList("ahk_class CabinetWClass")

SetTimer(UpdateExplorerList, 1000)


UpdateExplorerList() {
    global explorer_list
    global explorer_index
    new_list := WinGetList("ahk_class CabinetWClass")
    if new_list.Length != explorer_list.Length {
        explorer_list := new_list
        if explorer_index > explorer_list.Length {
            explorer_index := 1
        }
    }
}

explorer_index := 1
RShift & f:: {
    explorer()
}

RShift & d:: {
    activate("ahk_exe Discord.exe")
}
explorer() {
    if !WinExist("ahk_class CabinetWClass") {
        return
    }
    global explorer_index
    global explorer_list
    if !WinActive("ahk_class CabinetWClass") {
        WinActivate("ahk_id " explorer_list[explorer_index])
    } else {
        explorer_index++
        if explorer_index == explorer_list.Length + 1 {
            explorer_index := 1
        }
        WinActivate("ahk_id " explorer_list[explorer_index])
    }
}

RShift & v:: {
    activate("ahk_exe devenv.exe")
}

#HotIf WinActive("ahk_exe AutoHotkey64.exe")
Esc:: {
    ExitApp()
}
#HotIf

; F2:: {
;     MsgBox(delay.Value)
; }

#HotIf not WinActive("ahk_exe javaw.exe")
F1::LButton
#HotIf

#HotIf WinActive("ahk_exe vivaldi.exe")
^p:: {
    Send("{F2}")
}
#HotIf

#HotIf WinActive("ahk_exe msedge.exe") or WinActive("ahk_exe chrome.exe") or WinActive("ahk_exe vivaldi.exe")
; ctrl+p -> ctrl+shift+a
^p::
{
    Send("^+a")
}
; ` -> move mouse to center of screen and left click (gets out of weird vimium softlocks)
`::
{
    center_mouse()
}
F9::
{
    ; ctrl w
    Send("^w")
}
F10::
{
    ; ctrl shift t
    Send("^+t")
}
#HotIf
center_mouse() {
    MouseMove(1280, 720)
    Send("{LButton}")
    ; sleep 100 and press esc
    Sleep(100)
    Send("{Esc}")
}

#HotIf WinActive("ahk_exe blender.exe")
; win -> middle mouse
LWin::MButton
#HotIf

; in vscode, f9 -> ctrl+shift+f9, then wait 1 second and press f9
#HotIf WinActive("ahk_exe Code.exe")
Esc:: {
    Send("{Esc}")
    SetCapsLockState("Off")
}
F9::
{
    Send("^+{F9}")
    Sleep(50)
    Send("{F9}")
}
#HotIf

#HotIf WinActive("ahk_exe mintty.exe")
^+c::^c
^c::^+c
^+v::^v
^v::^+v
#HotIf

#HotIf WinActive("ahk_exe VALORANT-Win64-Shipping.exe") or WinActive("ahk_exe Overwatch.exe") or WinActive("ahk_exe javaw.exe")
z::
{
    Send("{w down}")
}
#HotIf

#HotIf WinActive("ahk_exe Overwatch.exe")
x::
{
    Send("{LButton down}")
}
#HotIf

autoclick := false


; you can't nest this inside #hotif javaw.exe
#HotIf uhc.Value and WinActive("ahk_exe javaw.exe")
q::
{
    Send("2")
    Sleep(50)
    Send("{RButton}")
    Sleep(150)
    Send("F")
    Sleep(50)
    global autoclick
    autoclick := true
}

3::
{
    Send("3")
    Sleep(50)
    Send("{RButton}")
    Sleep(50)
    Send("F")
}

XButton1::
{
    global autoclick
    autoclick := false
    Send(8)
    Sleep(50)
    Send("{RButton}")
    Sleep(150)
    Send("{RButton}")
    Sleep(50)
    Send("F")
    autoclick := true
}


c::
{
    global autoclick
    autoclick := false
    Send("c")
    Sleep(100)
    Send("{RButton}")
    Sleep(100)
    Send("F")
    autoclick := true
}
#HotIf

NumpadMult::Volume_Down
NumpadSub::Volume_Up

#HotIf WinActive("ahk_exe javaw.exe")
SetTimer(Auto, click_delay.Value)
SetTimer(AutoRight, 100)
click_changed(*) {
    MsgBox("changed to " click_delay.Value)
    SetTimer(Auto, click_delay.Value)
}

XButton2::
{
    global autoclick
    autoclick := !autoclick
    return
}

`::
; type /play duels_combo_duel in chat
{
    Send("t")
    Sleep(100)
    SendText("/play duels_combo_duel")
    Sleep(100)
    Send("{Enter}")
}
Auto()
{
    global autoclick
    if autoclick {
        Click()
    }
}

AutoRight()
{
    if GetKeyState("XButton1") {
        MouseClick("right")
    }
}


#HotIf

#HotIf combo_x.Value and WinActive("ahk_exe javaw.exe")
x::
{
    global autoclick
    autoclick := true
    Send(3)
    Send("{RButton down}")
    Sleep(1750)
    Send(4)
    Sleep(200)
    Send(2)
    Sleep(1800)
    Send("{RButton up}")
    Sleep(200)
    Send("f")
    Sleep(200)
    autoclick := true
    return
}
#HotIf


close(*) {
    ExitApp()
}

#Requires AutoHotkey v2.0
ShellRun(prms*)
{
    shellWindows := ComObject("Shell.Application").Windows
    desktop := shellWindows.FindWindowSW(0, 0, 8, 0, 1) ; SWC_DESKTOP, SWFO_NEEDDISPATCH

    ; Retrieve top-level browser object.
    tlb := ComObjQuery(desktop,
        "{4C96BE40-915C-11CF-99D3-00AA004AE837}", ; SID_STopLevelBrowser
        "{000214E2-0000-0000-C000-000000000046}") ; IID_IShellBrowser

    ; IShellBrowser.QueryActiveShellView -> IShellView
    ComCall(15, tlb, "ptr*", sv := ComValue(13, 0)) ; VT_UNKNOWN

    ; Define IID_IDispatch.
    NumPut("int64", 0x20400, "int64", 0x46000000000000C0, IID_IDispatch := Buffer(16))

    ; IShellView.GetItemObject -> IDispatch (object which implements IShellFolderViewDual)
    ComCall(15, sv, "uint", 0, "ptr", IID_IDispatch, "ptr*", sfvd := ComValue(9, 0)) ; VT_DISPATCH

    ; Get Shell object.
    shell := sfvd.Application

    ; IShellDispatch2.ShellExecute
    shell.ShellExecute(prms*)
}

Pause::Volume_Mute

; This is the key combo.
#HotIf WinActive("ahk_exe explorer.exe")
`::
{
    ; Cache the current clipboard contents.
    clipboard := A_Clipboard

    ; Clear the clipboard & copy selected files.
    A_Clipboard := ""
    Send("^c")

    ; increase wait time if clipboard data is not ready
    ClipWait(0.1)

    hwnd := WinGetID("A")

    for window in ComObject("Shell.Application").Windows {
        if (window && window.hwnd && window.hwnd == hwnd) {
            ; Get the current folder's path.
            path := window.Document.Folder.Self.Path
        }
    }

    ShellRun("C:\Users\" A_UserName "\AppData\Local\Programs\Microsoft VS Code\code.exe", path)
    ; Run("C:\Users\pblpbl\AppData\Local\Programs\Microsoft VS Code\code.exe", path)
}
#HotIf