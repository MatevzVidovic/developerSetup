



npm install -g @anthropic-ai/claude-code

mkdir -p ~/.claude


# I tried making a global settings.json in .claude/ that would autoapprove all reads and such.
# It didnt work.
# Just do this:

# maybe Write could be added - do what you like

alias cla="claude --dangerously-skip-permissions --allowedTools Bash,Read,Glob,Grep,WebFetch,WebSearch,TodoWrite,Task,BashOutput,KillShell"

# You then just shift+tab away from the dangerous permission mode
# Use it when you feel like it.

# And shift+tab to auto-approve edits. And there, edits in your curr dir and subdirs are allowed.
# Which is a nice way of doing it, because you have that stuff under git, and you can rollback those changes.

# Also, set model to: plan mode using claude opus, otherwise sonnet.
# Its the best - you just change your model on the fly in the convo when you feel like it, by changing the mode.
# And its the best setup anyway - its even better for a dumb model to implement the changes, or so i've heard.


# Btw, make s and p aliases for 
# s=(add everything, commit it with some whatever msg)
# p=(git push)
# This way you keep saving after each prompt, and you can rollback to any change.
# If working on a serious repo, just do: 
# git rebase -i
# later, to squash commits into nice chunks with proper commis msgs.

# Use dangerous permission mode when you feel like it, because:
<!-- some commands, like python commands and whatever, will
still request your approval. If you choose the option of approving them for the future, the auto-allow should be  saved in your .claude and it will be nice in the future.
But sometmes even that is still annoying.
So you just want to approve everything and let it rip. -->


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
