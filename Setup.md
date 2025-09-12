

## OSsetup

Open it in file explorer and double click the setup.ahk.

Then make it persistent:

; Persistent across reboots:
; Press Win + R, type shell:startup, press Enter
; It opens the folder of scripts that get run when the system boots.
; Right click the file explorer and open the terminal - copy the path.
; (the path is sth like C:\Users\Uporabnik\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
; make it be ~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup)
; then
; In PowerShell (run as administrator), go to the folder containing this script.
; New-Item -ItemType SymbolicLink -Path "~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\setup.ahk" -Target "$(Get-Location)\setup.ahk"



## GitSetup

cd GitSetup

then
ln -s /mnt/c/Users/Uporabnik/Desktop/developerSetup/GitSetup/.gitconfig ~/.gitconfig




## WSL setup

cd /mnt/c/Users/User/Desktop

mkdir WSL

 echo "alias wsl='cd /mnt/c/Users/User/Desktop/WSL'" >> ~/.bashrc && source ~/.bashrc




 ## ClaudeCodeSetup/General

cd ClaudeCodeSetup/General

cp settings.local.json ~/.claude/settings.local.json

### Also, for wsl:

cd /mnt/c/Users/User/Desktop/developerSetup/
cd ClaudeCodeSetup/General

cp settings.local.json ~/.claude/settings.local.json
