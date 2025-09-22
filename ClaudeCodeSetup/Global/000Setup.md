



npm install -g @anthropic-ai/claude-code

mkdir -p ~/.claude



# For some reason, at least for WSL, making a symbolic link doesnt work. So you have to actualyl copy settings.local.json into .claude/

cp settings.json ~/.claude/settings.json

# This autoallows all edits inside cwd, and all reads across the system.
# For some reason, it will sometimes still prompt you for stuff. It is what it is.


# Make your own commands:
# We have the commands/ dir here. 
# Cd into this commands/ dir (in this repo)
# Link it into the global .claude
ln -s $(pwd) ~/.claude/commands
# In it, make sth like: commit.md
# You will then be able to use /commit inside claude
# In md, do sth like:

---
description: Create a meaningful git commit using git cm
argument-hint: [commit message]
allowed-tools: Bash(git:*)
---

Create a git commit with the message: $ARGUMENTS

Use `git commit -m "$ARGUMENTS"` to make the commit.
