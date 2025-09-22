
; PowerToys FUCKING SUUUUUUUUUUUCKS!!!!!
; Could not get it to fucking apply.
; AutoHotkey v2 for the fucking win!!!!!!!!!!!!!

; Just download it, double-click this .ahk file, and everything just works (also for future boots). 
; (or make a sthsth.ahk, then double click it to run it)



; Persistent across reboots:
; Press Win + R, type shell:startup, press Enter
; It opens the folder of scripts that get run when the system boots.
; Right click the file explorer and open the terminal - copy the path.
; (the path is sth like C:\Users\Uporabnik\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
; make it be ~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup)
; then
; In PowerShell (run as administrator), go to the folder containing this script.
; New-Item -ItemType SymbolicLink -Path "~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\setup.ahk" -Target "$(Get-Location)\setup.ahk"
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

; Shift+Enter mapping completely removed to test Claude Code behavior
; No Shift+Enter handling at all

; =========================================
; 0. !!!DISABLE!!! Y/Z CHARACTER REMAPPING (QWERTY <-> QWERTZ)
; =========================================
; Basic Y/Z swap - DISABLED
; y::y
; z::z

; Y/Z swap with Shift (for capital letters) - DISABLED to fix Shift+Enter
; These mappings interfere with Shift combinations in browsers
; +y::Y
; +z::Z

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

; Alternative Redo shortcuts - now handled in terminal-aware section below

; Note: Alt+Z, Alt+Y, Alt+Shift+Z are now handled in the terminal-aware section below

; Terminal-aware shortcuts - use different keys for terminals vs other apps
!c:: {
    ; Check if we're in a terminal application
    if (WinActive("ahk_exe WindowsTerminal.exe") || WinActive("ahk_exe wt.exe") || 
        WinActive("ahk_exe powershell.exe") || WinActive("ahk_exe cmd.exe") || 
        WinActive("ahk_exe ubuntu.exe") || WinActive("ahk_exe wsl.exe")) {
        ; In terminal: use Ctrl+Shift+C for copy (avoids sigint)
        Send("^+c")
    } else {
        ; In other apps: use normal Ctrl+C
        Send("^c")
    }
}

!v:: {
    ; Check if we're in a terminal application
    if (WinActive("ahk_exe WindowsTerminal.exe") || WinActive("ahk_exe wt.exe") || 
        WinActive("ahk_exe powershell.exe") || WinActive("ahk_exe cmd.exe") || 
        WinActive("ahk_exe ubuntu.exe") || WinActive("ahk_exe wsl.exe")) {
        ; In terminal: use Ctrl+Shift+V for paste
        Send("^+v")
    } else {
        ; In other apps: use normal Ctrl+V
        Send("^v")
    }
}

!x:: {
    ; Cut action - less problematic in terminals but keep consistent
    if (WinActive("ahk_exe WindowsTerminal.exe") || WinActive("ahk_exe wt.exe") || 
        WinActive("ahk_exe powershell.exe") || WinActive("ahk_exe cmd.exe") || 
        WinActive("ahk_exe ubuntu.exe") || WinActive("ahk_exe wsl.exe")) {
        ; In terminal: use Ctrl+Shift+X if supported, otherwise just copy
        Send("^+c")
    } else {
        ; In other apps: use normal Ctrl+X
        Send("^x")
    }
}

!z:: {
    ; Undo - safe to use Ctrl+Z in most contexts
    Send("^z")
}

!y:: {
    ; Redo action (primary)
    Send("^y")
}

; !+z:: {
;     ; Redo action (Alt+Shift+Z) - TEMPORARILY DISABLED
;     Send("^y")
; }

; Other common shortcuts that can safely use Ctrl+ mapping
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

; Shift + Numpad combinations (when NumLock is OFF)
+NumpadClear::Send("\")        ; Shift+/ becomes \
+NumpadEnd::Send("<")        ; Shift+Numpad1 (End when NumLock off) becomes <
+NumpadDown::Send(">")      ; Shift+Numpad2 (Down when NumLock off) becomes >

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
; Win+Space for default Windows search (same as pressing Win key)
#Space::Send("#")

; Alt+Shift+Backspace for Delete - TEMPORARILY DISABLED to test Shift+Enter
; !+BackSpace::Send("{Delete}")

; Preserve Shift+Enter by doing nothing (let it pass through normally)
; No mapping for Shift+Enter - this allows it to work naturally


; =========================================
; 8. RESERVED FOR FUTURE USE
; =========================================
; Terminal-specific shortcuts removed as per new spec

; =========================================
; 9. SPECIAL HANDLING FOR SHIFT COMBINATIONS
; =========================================

; Fn key combinations - Page navigation with half-page scrolling
; PgUp/PgDn modified to scroll half a page instead of full page
PgUp:: {
    ; Send multiple up arrows to simulate half-page scroll
    Loop 15 {
        Send("{Up}")
    }
}

PgDn:: {
    ; Send multiple down arrows to simulate half-page scroll
    Loop 15 {
        Send("{Down}")
    }
}

; Home/End for start/end of line (already default behavior)
Home::Send("{Home}")        ; Start of line
End::Send("{End}")          ; End of line

; =========================================
; 10. HOT CORNER SETUP (Bottom Left: Sleep, Bottom Right: Lock)
; =========================================
; Hot corners functionality
; SetTimer(CheckCorners, 100)

; ; Variable to track if action was already triggered
; global CornerTriggered := false
; global LastCornerTime := 0

; CheckCorners() {
;     global CornerTriggered, LastCornerTime
    
;     ; Get current mouse position
;     MouseGetPos(&MouseX, &MouseY)
    
;     ; Get monitor dimensions
;     MonitorGet(MonitorGetPrimary(), &MonLeft, &MonTop, &MonRight, &MonBottom)
    
;     ; Define corner detection area (5 pixels)
;     CornerSize := 5
    
;     ; Check if we're in a corner
;     InLeftBottom := (MouseX <= MonLeft + CornerSize && MouseY >= MonBottom - CornerSize)
;     InRightBottom := (MouseX >= MonRight - CornerSize && MouseY >= MonBottom - CornerSize)
    
;     ; If not in any corner, reset the trigger
;     if (!InLeftBottom && !InRightBottom) {
;         CornerTriggered := false
;         return
;     }
    
;     ; If already triggered, don't trigger again until mouse leaves corner
;     if (CornerTriggered) {
;         return
;     }
    
;     ; Prevent rapid triggers (1 second cooldown)
;     CurrentTime := A_TickCount
;     if (CurrentTime - LastCornerTime < 1000) {
;         return
;     }
    
;     ; Left bottom corner - SLEEP
;     if (InLeftBottom) {
;         CornerTriggered := true
;         LastCornerTime := CurrentTime
;         ; Wait a moment to ensure intentional trigger
;         Sleep(300)
;         ; Check again if still in corner
;         MouseGetPos(&MouseX2, &MouseY2)
;         if (MouseX2 <= MonLeft + CornerSize && MouseY2 >= MonBottom - CornerSize) {
;             ; Put computer to sleep
;             DllCall("PowrProf\SetSuspendState", "Int", 0, "Int", 0, "Int", 0)
;         }
;     }
    
;     ; Right bottom corner - LOCK
;     if (InRightBottom) {
;         CornerTriggered := true
;         LastCornerTime := CurrentTime
;         ; Wait a moment to ensure intentional trigger
;         Sleep(300)
;         ; Check again if still in corner
;         MouseGetPos(&MouseX2, &MouseY2)
;         if (MouseX2 >= MonRight - CornerSize && MouseY2 >= MonBottom - CornerSize) {
;             ; Lock workstation
;             DllCall("User32\LockWorkStation")
;         }
;     }
; }


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

