



ln -s ./.claude ~/Desktop/developerSetup/ClaudeCodeSetup/.claude

# # For windows ones first move to ClaudeCodeSetup/GitSetup/

<!-- # # In Command Prompt (run as administrator)
# mklink "%USERPROFILE%\.gitconfig" "%CD%\.gitconfig" -->

# # In PowerShell (run as administrator)
# # Move to GitSetup/
# New-Item -ItemType SymbolicLink -Path "$(Get-Location)\.claude" -Target "~\Desktop\developerSetup\ClaudeCodeSetup\.claude"
# reading the link:
# (Get-Item -Path ".claude" -Force).Target