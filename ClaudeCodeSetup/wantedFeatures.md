
  Claude Code Setup & Configuration

  - Make Claude commands autoallowed (or create list of autoallowed commands)
  - How to add directories for Claude Code to consider (working in worktree)

 Claude wrapper around project directory: 
- To have .md files for development guiding (what kind of unit tests to make, integration tests, linter setups, to make code as independent and modular as possible (its much nicer to have self-contained modules that are reusable for other projects also - they can also be nicely tested and are more stable), to try to make code have as little state as possible while not sacrificing readability and simplicity (leaning towards functional programming). Basically, how to make it so that claude code often reads these .md files and follows them, and what the contents should be.
- And to have makefiles/taskfiles that claude code can use while working inside the project directory. I also want task commands that allow claude code to see the diffs of past commits, and diff of a series of commits




  MCP (Model Context Protocol) Servers

 - How to create custom MCP, and how will Claude Code know when it is useful to call it
 - Mainly Zen MCP so the model can consult other models, and additional websearch integration (like maybe having a cheap fast model search a bunch of pages and get exactly the relevant data)
  - Google Keep MCP
  - GitHub MCP for project planning
  - Atlassian CLI for Jira ticket creation and reading existing tickets


How I would have gitrepo directories with files in them, where claude code can then do all analysis and add stuff to them.

===================================

Claude for VS Code extension

Make Gemini CLI into a MCP server, maybe add it to Zen, so i can have modelconsultation for free




