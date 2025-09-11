
; PowerToys FUCKING SUUUUUUUUUUUCKS!!!!!
; Could not get it to fucking apply.
; AutoHotkey v2 for the fucking win!!!!!!!!!!!!!

; Just download it, double-click this .ahk file, and everything just works (also for future boots). 
; (or make a sthsth.ahk, then double click it to run it)



; Persistent across reboots:
; Press Win + R, type shell:startup, press Enter
; It opens the folder of scripts that get run when the system boots.
; Right click the file explorer and open the terminal - copy the path.
; (the path is sth like C:\Users\Uporabnik\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup)
; then
; In PowerShell (run as administrator), go to the folder containing this script.
; New-Item -ItemType SymbolicLink -Path "C:\Users\Uporabnik\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\setup.ahk" -Target "$(Get-Location)\setup.ahk"
; reading the link:
; (Get-Item -Path ".gitconfig" -Force).Target



; =========================================
; macOS to Windows Migration AutoHotkey v2 Script
; =========================================
; This script replicates macOS shortcuts on Windows
; Designed for English US/Slovenian keyboard layout
; Compatible with AutoHotkey v2.0+

; to diable the the script, right-click the autoHotkey icon and check Suspend Hotkeys

#Requires AutoHotkey v2.0
#SingleInstance Force
; #NoEnv ; ahk v1 only
; #Persistent ; ahk v1 only
; Persistent(true) ; Built-in function (if your v2 version supports it)
SendMode("Input")

; =========================================
; 0. !!!DISABLE!!! Y/Z CHARACTER REMAPPING (QWERTY <-> QWERTZ)
; =========================================
; Basic Y/Z swap
y::y
z::z

; Y/Z swap with Shift (for capital letters)
+y::Y
+z::Z

; =========================================
; 1. CAPSLOCK AS ESCAPE (for Vim users)
; =========================================
CapsLock::Escape

; =========================================
; 2. ALT + KEY MAPS TO CTRL + KEY (General rule)
; =========================================
; IMPORTANT: Disable Windows Alt+Shift language switch first! 
; Go to Settings → Time & Language → Language & region → Advanced keyboard settings 
; → Language bar options → Advanced Key Settings → "Between input languages" → "Not Assigned"

; Alternative Redo shortcuts
; Use Alt+Y as primary Redo (matches Ctrl+Y standard)
!y::Send("^y")      ; Redo - Primary option

; Use traditional hotkey syntax - Alt+Shift+Z MUST come before Alt+Z
!+z::Send("^y")     ; Alt+Shift+Z for Redo (must come BEFORE Alt+Z)
!z::Send("^z")      ; Alt+Z for Undo

; Common shortcuts - using traditional syntax
!c::Send("^c")      ; Copy
!v::Send("^v")      ; Paste
!x::Send("^x")      ; Cut
!a::Send("^a")      ; Select All
!s::Send("^s")      ; Save
!n::Send("^n")      ; New
!r::Send("^r")      ; Refresh/Reload
!t::Send("^t")      ; New Tab
!f::Send("^f")      ; Find

; =========================================
; 3. WINDOW/TAB MANAGEMENT
; =========================================
; Alt+W (Cmd+W) - Close current tab
!w::Send("^w")

; Alt+Q (Cmd+Q) - Quit application completely
!q::Send("!{F4}")

; Alt+E - Close current window (not all windows, not just tab)
; This will close the current window of the application
!e::WinClose("A")

; Tab navigation with number keys (these don't interfere with Alt+Tab)
; (Number hotkeys are defined in the Window/Tab Management section below)

; Number keys for tab switching (Alt+1, Alt+2, etc.)
!1::Send("^1")
!2::Send("^2")
!3::Send("^3")
!4::Send("^4")
!5::Send("^5")
!6::Send("^6")
!7::Send("^7")
!8::Send("^8")
!9::Send("^9")

; =========================================
; 4. VIRTUAL DESKTOP MANAGEMENT
; =========================================
; Use specific three-key combinations instead of intercepting all Win+Arrow
; Win+Alt+Up - Open Task View (Virtual Desktops)
#!Up::Send("#{Tab}")

; Win+Alt+Left/Right - Switch between virtual desktops
#!Left::Send("^#{Left}")
#!Right::Send("^#{Right}")

; =========================================
; 5. NUMPAD REMAPPING (when NumLock is OFF)
; =========================================
; Check if NumLock is off and remap accordingly

; Create hotkeys that only work when NumLock is OFF
#HotIf !GetKeyState("NumLock", "T")

; Numbers 1-9 remapped
NumpadEnd::Send("(")       ; Numpad1 (End when NumLock off)
NumpadDown::Send("{{}}")    ; Numpad2 (Down when NumLock off) - { needs escaping
NumpadPgDn::Send("[")       ; Numpad3 (PgDn when NumLock off)
NumpadLeft::Send("~")       ; Numpad4 (Left when NumLock off)
NumpadClear::Send("/")      ; Numpad5 (Clear when NumLock off)
NumpadRight::Send("_")      ; Numpad6 (Right when NumLock off)
NumpadHome::Send("=")       ; Numpad7 (Home when NumLock off)
NumpadUp::Send("|")         ; Numpad8 (Up when NumLock off)
NumpadPgUp::Send("´")       ; Numpad9 (PgUp when NumLock off)

; Operation symbols
NumpadDiv::Send(")")        ; / becomes )
NumpadMult::Send("{}}")      ; * becomes } - needs escaping
NumpadSub::Send("]")        ; - becomes ]
NumpadAdd::Send("@")        ; + becomes @
NumpadEnter::Send("{^}")     ; Enter becomes ^ - needs escaping

; Special keys
NumpadIns::Send("{%}")       ; Numpad0 (Ins when NumLock off) - % needs escaping
NumpadDel::Send("&")         ; NumpadDot (Del when NumLock off)

#HotIf

; =========================================
; 6. BROWSER-SPECIFIC OPTIMIZATIONS
; =========================================
; Browser navigation using Alt+Left/Right for tab switching
; Consistent with macOS Cmd+Left/Right behavior

#HotIf WinActive("ahk_exe chrome.exe") || WinActive("ahk_exe firefox.exe") || WinActive("ahk_exe msedge.exe") || WinActive("ahk_exe brave.exe")
!Left::Send("^{PgUp}")       ; Alt+Left - Previous tab
!Right::Send("^{PgDn}")      ; Alt+Right - Next tab
#HotIf

; =========================================
; 7. ADDITIONAL USEFUL SHORTCUTS
; =========================================
; Alt+Space for Spotlight-like functionality (Windows Search)
!Space::Send("#s")

; Win+Space for default Windows search (redundant but matches Mac muscle memory)
#Space::Send("#")

; Win+Tab behaves like Alt+Tab
LWin & Tab::AltTab

; Win+Up opens Task View (what Win+Tab used to do)
#Up::Send("#{Tab}")

; Win+Left/Right for virtual desktop switching
#Left::Send("^#{Left}")
#Right::Send("^#{Right}")

; Alt+Shift+Backspace for Delete
!+BackSpace::Send("{Delete}")

; Shift+Arrow keys for word-by-word selection (swap with default behavior)
+Left::Send("^+{Left}")     ; Select word left
+Right::Send("^+{Right}")   ; Select word right
+Up::Send("^+{Up}")         ; Select paragraph up
+Down::Send("^+{Down}")     ; Select paragraph down

; Ctrl+Shift+Arrow keys for character-by-character selection
^+Left::Send("+{Left}")     ; Select character left
^+Right::Send("+{Right}")   ; Select character right
^+Up::Send("+{Up}")         ; Select line up
^+Down::Send("+{Down}")     ; Select line down

; =========================================
; 8. WSL/TERMINAL SPECIFIC SHORTCUTS
; =========================================
#HotIf WinActive("ahk_exe WindowsTerminal.exe") || WinActive("ahk_exe wt.exe") || WinActive("ahk_exe powershell.exe") || WinActive("ahk_exe cmd.exe")
; Alt+C/V/X for copy/paste/cut in terminal
!c::Send("^+c")
!v::Send("^+v")
!x::Send("^+x")

; Alt+U to delete current line (Ctrl+U in terminal)
!u::Send("^u")

; Tab navigation in terminal
!1::Send("^!1")
!2::Send("^!2")
!3::Send("^!3")
!4::Send("^!4")
!5::Send("^!5")
!6::Send("^!6")
!7::Send("^!7")
!8::Send("^!8")
!9::Send("^!9")

; Alt+Left/Right for tab navigation in terminal
!Left::Send("^+{Tab}")       ; Previous tab
!Right::Send("^{Tab}")       ; Next tab

; Alt+T for new tab
!t::Send("^+t")

; Alt+Shift+T for new tab with same directory
!+t::Send("^+d")

; Alt+F for search in terminal
!f::Send("^+f")
#HotIf

; =========================================
; 9. SPECIAL HANDLING FOR SHIFT COMBINATIONS & FILE EXPLORER
; =========================================
; File Explorer specific shortcuts
#HotIf WinActive("ahk_class CabinetWClass") || WinActive("ahk_class ExploreWClass")
; Alt+Shift+N for new folder (Cmd+Shift+N on Mac)
!+n::Send("^+n")
#HotIf

; Fn key combinations (using F13-F24 as Fn modifier simulation)
; Since most keyboards don't have true Fn key detection, we'll use alternatives
; Page navigation
Home::Send("{Home}")        ; Already goes to start of line
End::Send("{End}")          ; Already goes to end of line
; Modified Page Up/Down for half-page scrolling
PgUp::Send("^{Up 10}")       ; Move up approximately half page
PgDn::Send("^{Down 10}")     ; Move down approximately half page

; =========================================
; 10. HOT CORNER SETUP (Bottom Left: Sleep, Bottom Right: Lock)
; =========================================
; Hot corners functionality
SetTimer(CheckCorners, 100)

; Variable to track if action was already triggered
global CornerTriggered := false
global LastCornerTime := 0

CheckCorners() {
    global CornerTriggered, LastCornerTime
    
    ; Get current mouse position
    MouseGetPos(&MouseX, &MouseY)
    
    ; Get monitor dimensions
    MonitorGet(MonitorGetPrimary(), &MonLeft, &MonTop, &MonRight, &MonBottom)
    
    ; Define corner detection area (5 pixels)
    CornerSize := 5
    
    ; Check if we're in a corner
    InLeftBottom := (MouseX <= MonLeft + CornerSize && MouseY >= MonBottom - CornerSize)
    InRightBottom := (MouseX >= MonRight - CornerSize && MouseY >= MonBottom - CornerSize)
    
    ; If not in any corner, reset the trigger
    if (!InLeftBottom && !InRightBottom) {
        CornerTriggered := false
        return
    }
    
    ; If already triggered, don't trigger again until mouse leaves corner
    if (CornerTriggered) {
        return
    }
    
    ; Prevent rapid triggers (1 second cooldown)
    CurrentTime := A_TickCount
    if (CurrentTime - LastCornerTime < 1000) {
        return
    }
    
    ; Left bottom corner - SLEEP
    if (InLeftBottom) {
        CornerTriggered := true
        LastCornerTime := CurrentTime
        ; Wait a moment to ensure intentional trigger
        Sleep(300)
        ; Check again if still in corner
        MouseGetPos(&MouseX2, &MouseY2)
        if (MouseX2 <= MonLeft + CornerSize && MouseY2 >= MonBottom - CornerSize) {
            ; Put computer to sleep
            DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0)
        }
    }
    
    ; Right bottom corner - LOCK
    if (InRightBottom) {
        CornerTriggered := true
        LastCornerTime := CurrentTime
        ; Wait a moment to ensure intentional trigger
        Sleep(300)
        ; Check again if still in corner
        MouseGetPos(&MouseX2, &MouseY2)
        if (MouseX2 >= MonRight - CornerSize && MouseY2 >= MonBottom - CornerSize) {
            ; Lock workstation
            DllCall("User32\LockWorkStation")
        }
    }
}

; =========================================
; 11. MEDIA & SYSTEM CONTROLS
; =========================================
; Media controls (using F9-F12 as media keys)
F9::Volume_Mute         ; Mute/Unmute
F10::Volume_Down        ; Volume Down
F11::Volume_Up          ; Volume Up
F12::Media_Play_Pause   ; Play/Pause

; Alternative media controls with Alt modifier
!F9::Media_Prev         ; Previous track
!F10::Media_Next        ; Next track
!F11::Media_Stop        ; Stop

; Brightness controls (Windows doesn't have direct brightness keys like Mac)
; These will work on laptops with appropriate drivers
; Using Shift+F keys for brightness
+F1:: {
    ; Decrease brightness
    ; This is system-dependent and may not work on all systems
    Run("powershell.exe -Command (Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods).WmiSetBrightness(1,20)", , "Hide")
}

+F2:: {
    ; Increase brightness
    Run("powershell.exe -Command (Get-WmiObject -Namespace root/WMI -Class WmiMonitorBrightnessMethods).WmiSetBrightness(1,80)", , "Hide")
}


; =========================================
; NOTES AND IMPROVEMENTS FOR v2
; =========================================
; 
; IMPLEMENTED IN v2:
; - CapsLock as Escape
; - Alt+Key maps to Ctrl+Key for common shortcuts
; - Window/tab management (close tab, quit app, close window)
; - Virtual desktop switching
; - Numpad remapping when NumLock is off
; - Tab navigation and switching
; - Browser-specific optimizations
; - Terminal-specific shortcuts for multiple terminal apps
; - Proper v2 syntax with Send(), WinClose(), #HotIf
; - FIXED: Alt+Shift+Z now properly triggers Redo using traditional syntax
; - FIXED: Browser navigation now uses Alt+Shift+Left/Right to avoid Alt+Tab conflicts
;
; v2 IMPROVEMENTS:
; 1. More reliable hotkey conditions with #HotIf
; 2. Better string handling with quoted parameters
; 3. More robust window detection
; 4. Support for multiple terminal applications
; 5. Fixed hotkey precedence issues using traditional ! syntax
; 6. Browser navigation shortcuts no longer interfere with Alt+Tab
;
; BROWSER NAVIGATION CHANGE:
; - OLD: Alt+Left/Right for browser back/forward (conflicted with Alt+Tab)
; - NEW: Alt+Shift+Left/Right for browser back/forward (no conflicts)
;
; LIMITATIONS/NOT IMPLEMENTED:
; 1. Some applications may override these shortcuts
; 2. The numpad remapping might conflict with some applications
; 3. Virtual desktop management varies by Windows version
; 4. Default Alt+Tab behavior is preserved (commented out override)
;
; SETUP INSTRUCTIONS:
; 1. Install AutoHotkey v2 from https://autohotkey.com/
; 2. Save this script as a .ahk file
; 3. Double-click to run it
; 4. To run automatically on startup, place in Windows Startup folder:
;    Win+R, type "shell:startup", paste the .ahk file there
;
; For WSL integration, ensure Windows Terminal is configured
; to handle Ctrl+Shift+C/V for copy/paste operations.

; =========================================
; TROUBLESHOOTING
; =========================================
; If some shortcuts don't work:
; 1. Check if the target application has conflicting shortcuts
; 2. Run AutoHotkey as administrator for better compatibility
; 3. Use Window Spy (comes with AHK) to identify correct window titles
; 4. Adjust the #HotIf conditions based on your specific applications

; To disable specific sections, add semicolon (;) at the beginning of lines
; To modify shortcuts, change the key combinations as needed

; =========================================
; ADDITIONAL v2 FEATURES YOU CAN ADD
; =========================================
; 
; Example: Application-specific shortcuts
; #HotIf WinActive("ahk_exe Code.exe")  ; VS Code
; !`::Send("^`")  ; Terminal toggle in VS Code
; #HotIf
;
; Example: Custom functions for complex operations
; MyCustomFunction() {
;     ; Your custom code here
;     MsgBox("Custom function executed!")
; }
; F12::MyCustomFunction()  ; Call custom function with F12

