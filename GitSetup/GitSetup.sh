
ln -s $(pwd)/.gitconfig ~/.gitconfig

# # For windows ones first move to ClaudeCodeSetup/GitSetup/

# # In Command Prompt (run as administrator)
# mklink "%USERPROFILE%\.gitconfig" "%CD%\.gitconfig"

# # In PowerShell (run as administrator)
# New-Item -ItemType SymbolicLink -Path "~\.gitconfig" -Target "$(Get-Location)\.gitconfig"