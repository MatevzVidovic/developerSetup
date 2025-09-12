


# We will add .claude/ dir to ~ and add a link to this settings.local.json inside it.
# This way globally all of these commands will be autoallowed for claude code, so it doesn't get blocked when we are not looking.


mkdir -p ~/.claude

# # In PowerShell (run as administrator)
# # Move to General/
# New-Item -ItemType SymbolicLink -Path "~\.claude\settings.local.json" -Target "$(Get-Location)\settings.local.json"


ln -s ~/.claude/settings.local.json ./settings.local.json







# # For windows ones first move to ClaudeCodeSetup/GitSetup/

<!-- # # In Command Prompt (run as administrator)
# mklink "%USERPROFILE%\.gitconfig" "%CD%\.gitconfig" -->

# reading the link:
# (Get-Item -Path ".claude" -Force).Target