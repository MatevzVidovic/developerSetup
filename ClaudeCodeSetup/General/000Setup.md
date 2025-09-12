



# For some reason, at least for WSL, making a symbolic link doesnt work. So you have to actualyl copy settings.local.json into .claude/

cp settings.local.json ~/.claude/settings.local.json








# We will add .claude/ dir to ~ and add a link to this settings.local.json inside it.
# This way globally all of these commands will be autoallowed for claude code, so it doesn't get blocked when we are not looking.

# When you are working with claude code in some dir, it can then make its own .claude/settings.local.json where it has specific allowed commands for that directory 
# (because some might not be on this general autoallowed list)


mkdir -p ~/.claude

# # In PowerShell (run as administrator)
# # Move to General/
# New-Item -ItemType SymbolicLink -Path "~\.claude\settings.local.json" -Target "$(Get-Location)\settings.local.json"


ln -s $(pwd)/settings.local.json ~/.claude/settings.local.json







# # For windows ones first move to ClaudeCodeSetup/GitSetup/

<!-- # # In Command Prompt (run as administrator)
# mklink "%USERPROFILE%\.gitconfig" "%CD%\.gitconfig" -->

# reading the link:
# (Get-Item -Path ".claude" -Force).Target