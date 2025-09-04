
; PowerToys FUCKING SUUUUUUUUUUUCKS!!!!!
; Could not get it to fucking apply.
; AutoHotkey v2 for the fucking win!!!!!!!!!!!!!

; Just download it, double-click this .ahk file, and everything just works (also for future boots). 
; (or make a sthsth.ahk, then double click it to run it)






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
Numpad1::Send("(")
Numpad2::Send("{")
Numpad3::Send("[")
Numpad4::Send("~")
Numpad5::Send("/")
Numpad6::Send("_")
Numpad7::Send("=")
Numpad8::Send("|")
Numpad9::Send("´")

; Operation symbols
NumpadDiv::Send(")")      ; / becomes )
NumpadMult::Send("}")     ; * becomes }
NumpadSub::Send("]")      ; - becomes ]
NumpadAdd::Send("@")      ; + becomes @
NumpadEnter::Send("^")    ; Enter becomes ^

; Special keys
Numpad0::Send("%")        ; 0 becomes %
NumpadDot::Send("&")      ; Comma/Dot becomes &

#HotIf

; =========================================
; 6. BROWSER-SPECIFIC OPTIMIZATIONS
; =========================================
; Browser navigation (back/forward) using Alt+Shift+Left/Right
; This avoids conflict with Alt+Tab and preserves Alt+Left/Right for system use

#HotIf WinActive("ahk_exe chrome.exe")
!+Left::Send("^{PgUp}")      ; Alt+Shift+Left - Previous tab
!+Right::Send("^{PgDn}")     ; Alt+Shift+Right - Next tab
#HotIf

#HotIf WinActive("ahk_exe firefox.exe")
!+Left::Send("^{PgUp}")      ; Alt+Shift+Left - Previous tab
!+Right::Send("^{PgDn}")     ; Alt+Shift+Right - Next tab
#HotIf

#HotIf WinActive("ahk_exe msedge.exe")
!+Left::Send("^{PgUp}")      ; Alt+Shift+Left - Previous tab
!+Right::Send("^{PgDn}")     ; Alt+Shift+Right - Next tab
#HotIf

; =========================================
; 7. ADDITIONAL USEFUL SHORTCUTS
; =========================================
; Alt+Space for Spotlight-like functionality (Windows Search)
!Space::Send("#s")

; Alt+Tab equivalent (Cmd+Tab on Mac) - Note: this might conflict with system Alt+Tab
; Uncomment the line below if you want to override the default Alt+Tab behavior
; !Tab::AltTab

; =========================================
; 8. WSL/TERMINAL SPECIFIC SHORTCUTS
; =========================================
#HotIf WinActive("ahk_exe WindowsTerminal.exe")
; Alt+C/V for copy/paste in terminal (many terminals use Ctrl+Shift)
!c::Send("^+c")
!v::Send("^+v")
#HotIf

; Also handle other common terminals
#HotIf WinActive("ahk_exe wt.exe")
!c::Send("^+c")
!v::Send("^+v")
#HotIf

; PowerShell
#HotIf WinActive("ahk_exe powershell.exe")
!c::Send("^+c")
!v::Send("^+v")
#HotIf

; =========================================
; 9. SPECIAL HANDLING FOR SHIFT COMBINATIONS
; =========================================
; Additional shift combinations can be added here if needed
; Example: Alt+Shift+T for new tab in some applications
; !+t::Send("^+t")

; =========================================
; 10. HOT CORNER SETUP (Bottom Left: Sleep, Bottom Right: Lock)
; =========================================
#SingleInstance Force

SetTimer(CheckCorners, 100)

CheckCorners() {
    MouseGetPos(&MouseX, &MouseY)
    MonitorGet(1, &MonLeft, &MonTop, &MonRight, &MonBottom)
    
    ; Left bottom corner - SLEEP (larger detection area)
    if (MouseX <= 5 && MouseY >= MonBottom - 5) {
        Sleep(500)
        DllCall("powrprof.dll\SetSuspendState", "Int", 0, "Int", 0, "Int", 0)
        return
    }
    
    ; Right bottom corner - LOCK (larger detection area)
    if (MouseX >= MonRight - 5 && MouseY >= MonBottom - 5) {
        Sleep(500)
        DllCall("user32.dll\LockWorkStation")
        return
    }
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

