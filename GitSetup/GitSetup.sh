
ln -s /mnt/c/Users/Uporabnik/Desktop/developerSetup/GitSetup/.gitconfig ~/.gitconfig

# # For windows ones first move to ClaudeCodeSetup/GitSetup/

# # In Command Prompt (run as administrator)
# mklink "%USERPROFILE%\.gitconfig" "%CD%\.gitconfig"

# # In PowerShell (run as administrator)
# # Move to GitSetup/
# New-Item -ItemType SymbolicLink -Path "~\.gitconfig" -Target "$(Get-Location)\.gitconfig"
# reading the link:
# (Get-Item -Path ".gitconfig" -Force).Target