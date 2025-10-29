

  Claude Code Setup & Configuration

- Make Claude commands autoallowed (or create list of autoallowed commands)

This makes everything sooooo much faster. Because it isnt constantly blocked by waiting for my input

Allow everything, but for write and edit commands allow them only for ./**
I am running this in a git repo and have an alias "git s" for instant saving of things. I do this save after every prompt is finished.
So whatever claude code edits in this directory or the subdirectories, I can always just roll back.
But for other dirs, its a lot harder to revert.
So in those cases, it asks me for permission. And if it's a save directory to edit stuff in, I give the "always allow" option and it saves that in its .claude/ dir and doesnt ask again.
Its just really awesome.
This almost never happens, so its almost never blocked.
And I can feel perfectly safe letting it run in the background, because I know it won't change anything unusual.


- How to add directories for Claude Code to consider (working in worktree)
It says I can do this with --path when running claude code, or do the /open command when using it.
But idk. Idc rn.

- to give a popup notification when it needs my input (like allowing something), and a (possibly different) popup when it finished working on my prompt.

Already existing features:

- Have navigation to previous prompts (so i can jump to where the previous prompt was)
Just ctrl F for >

- To be able to copy my prompts and to copy what claude generated, without having the unnecessary | at the start of each line.
Somehow this already works now.