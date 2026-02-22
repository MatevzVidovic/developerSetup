



## MCP servers are so much easier now

Used to have to set up docker containers for them and connect to CLI LLMs.
Now we just give them to claude or codex with mcp add command and they get started as subprocesses.


## Useful MCP servers

Free and awesome:

Context7 — pulls live, version-accurate docs for any library directly into context on demand, so Claude doesn't hallucinate outdated APIs.

Serena — gives Claude IDE-like code intelligence: instead of reading whole files, it can navigate by symbol (find_symbol, find_referencing_symbols, insert_after_symbol) using LSP under the hood. Much more token-efficient on large codebases.

Paid or not:

Zen MCP — Claude delegates tasks to other models (Gemini, GPT, O3, Ollama, etc.) with full conversation threading; also has built-in dev workflows like codereview, debug, precommit that run structured multi-step analysis. Note: renamed to PAL MCP now.
Can also use gemini api keys, which have free use.

Paid:

Consult7 — sends files/code to a model with a massive context window (Gemini 1M, etc.) when your codebase is too big for Claude's window; ask a question, get an answer back. Can only use OpenRouter.

Less useful:

Playwright MCP — Claude controls a real browser: clicks, fills forms, takes screenshots, runs tests. Official Microsoft repo.

SuperClaude Framework — not really an MCP, more a Claude Code config layer: injects slash commands (/sc:build, /sc:review, etc.) and structured persona prompts to make Claude Code behave more systematically. Framework, not a tool.


https://github.com/upstash/context7
https://github.com/oraios/serena

https://github.com/BeehiveInnovations/zen-mcp-server

https://github.com/szeider/consult7

https://github.com/SuperClaude-Org/SuperClaude_Framework
https://github.com/microsoft/playwright-mcp


## Important on playwright and superclaude

### superclaude (we are skipping it for now)

Worth knowing: because it injects a large system prompt globally, it will affect all your claude sessions including cla, clar etc. — not just dedicated ones. Some people love it, some find it too opinionated. You can always uninstall by removing what it wrote to ~/.claude/.

### playwright

Playwright is intentionally left out of both aliases because browser control is destructive/side-effectful enough to warrant its own alias (clap or similar) when you explicitly need it.




# Prepare for install

brew install uv

## do you have it

which uv
which uvx
uvx --version






###############################################################################
# MCP setup commands (Claude Code + OpenAI Codex CLI)
# Assumes Node + npx available for the npx-based servers, and uv/uvx for Python.
###############################################################################

########################
# Claude Code (user scope)
########################

# Context7 (live docs)
claude mcp add --transport stdio --scope user context7 -- npx -y @upstash/context7-mcp
# Optional higher limits:
# claude mcp add --transport stdio --scope user --env CONTEXT7_API_KEY=YOUR_KEY context7 -- \
#   npx -y @upstash/context7-mcp

# Serena (symbol-level code navigation)
claude mcp add --transport stdio --scope user serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context=claude-code --project-from-cwd

# Consult7 (big-context offload; uses OpenRouter key)
claude mcp add --transport stdio --scope user consult7 -- uvx -- consult7 YOUR_OPENROUTER_API_KEY

# Zen (multi-model orchestration) — run as an MCP stdio process

claude mcp add --transport stdio --scope user zen -- uvx --from git+https://github.com/BeehiveInnovations/zen-mcp-server.git zen-mcp-server


########################
# Codex CLI (global config by default)
########################

# Context7
codex mcp add context7 -- npx -y @upstash/context7-mcp
# Optional higher limits:
# codex mcp add context7 --env CONTEXT7_API_KEY=YOUR_KEY -- \
#   npx -y @upstash/context7-mcp

# Serena
codex mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context=codex

# Consult7
codex mcp add consult7 -- uvx -- consult7 YOUR_OPENROUTER_API_KEY

# Zen (multi-model orchestration) — run as an MCP stdio process

codex mcp add -- --transport stdio --scope user zen -- uvx --from git+https://github.com/BeehiveInnovations/zen-mcp-server.git zen-mcp-server






###############################################################################
# Additional setup
###############################################################################


########################
# Claude Code (user scope)
########################


## 3 ways to give api keys to zen

#### by exporting vars before (my fav, because i can choose if i want to just use free gemini key or also openrouter)
export GEMINI_API_KEY="..."
export OPENROUTER_API_KEY="..."
claude   # or codex

#### .env file where claude or codex is started

#### baking them directly in the setup

claude mcp add --transport stdio --scope user zen \
  --env OPENROUTER_API_KEY=sk-or-REDACTED \
  --env GEMINI_API_KEY=REDACTED \
  -- uvx --from git+https://github.com/BeehiveInnovations/zen-mcp-server.git zen-mcp-server


# Playwright (unless doing frontend stuff, i wouldn't install this one)
claude mcp add --transport stdio --scope user playwright -- \
  npx -y @playwright/mcp@latest



########################
# Codex CLI (global config by default)
########################

## 3 ways to give api keys to zen

#### by exporting vars before (my fav, because i can choose if i want to just use free gemini key or also openrouter)
export GEMINI_API_KEY="..."
export OPENROUTER_API_KEY="..."
codex   # or codex

#### .env file where codex or codex is started

#### baking them directly in the setup

codex mcp add -- --transport stdio --scope user zen \
  --env OPENROUTER_API_KEY=sk-or-REDACTED \
  --env GEMINI_API_KEY=REDACTED \
  -- uvx --from git+https://github.com/BeehiveInnovations/zen-mcp-server.git zen-mcp-server


# Playwright (unless doing frontend stuff, i wouldn't install this one)
codex mcp add playwright -- \
  npx -y @playwright/mcp@latest















<!-- 
# old install instructions


## Claude mcp Install and setup

# 1. Zen/PAL (multi-model orchestration)
git clone https://github.com/BeehiveInnovations/zen-mcp-server.git ~/zen-mcp-server
cd ~/zen-mcp-server && ./run-server.sh
# creates its own config entry as "zen"

# 2. Context7 (live docs)
claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp
# optional: get free API key at context7.com/dashboard for higher limits
# then: claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp --api-key YOUR_KEY

# 3. Consult7 (big-context offload)

claude mcp add -s user consult7 uvx -- consult7 your-openrouter-api-key

Then create a config file at ~/.consult7/config.yaml (or wherever their README points) with your API keys. Claude Code launches it automatically like the others.

# 4. Serena (symbol-level code nav)
claude mcp add --scope user serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context claude-code --project-from-cwd

Serena is project-aware — with --project-from-cwd it auto-detects your project from wherever you run claude. If it doesn't activate, just tell it "activate the current project using serena" at the start of a session.

# 5. Playwright (browser control)
claude mcp add --scope user playwright -- npx -y @playwright/mcp@latest

# 6. SuperClaude — not an MCP, skip for aliases





## codex mcp setup

# Context7
codex mcp add context7 -- npx -y @upstash/context7-mcp

# Playwright
codex mcp add playwright -- npx -y @playwright/mcp@latest

# Serena
codex mcp add serena -- uvx --from git+https://github.com/oraios/serena serena start-mcp-server --context codex 
    # not using--project-from-cwd

# Zen
codex mcp add zen -- /path/to/zen-mcp-server/run-server.sh

# Consult7
codex mcp add consult7 -- uvx --from git+https://github.com/szeider/consult7 consult7-mcp -->






## Aliases


# clam: full dev worker + MCPs (same as cla but with MCP tools)
alias clam='claude \
  --allow-dangerously-skip-permissions \
  --permission-mode dontAsk \
  --allowedTools \
    "Bash(workspace_only:true)" \
    "Edit" \
    "Write" \
    "Read" \
    "WebSearch" \
    "TodoRead" \
    "TodoWrite" \
    "Grep" \
    "Glob" \
    "LS" \
    "WebFetch" \
    "NotebookEdit" \
    "MCPTool(zen:*)" \
    "MCPTool(context7:*)" \
    "MCPTool(consult7:*)" \
    "MCPTool(serena:*)"'

# clarm: read-only reviewer + MCPs (same as clar but with MCP tools)
alias clarm='claude \
  --allow-dangerously-skip-permissions \
  --permission-mode dontAsk \
  --allowedTools \
    "Bash(git log:*)" \
    "Bash(git diff:*)" \
    "Bash(git show:*)" \
    "Bash(git status:*)" \
    "Read" \
    "WebSearch" \
    "TodoRead" \
    "Grep" \
    "Glob" \
    "LS" \
    "WebFetch" \
    "NotebookEdit" \
    "MCPTool(zen:*)" \
    "MCPTool(context7:*)" \
    "MCPTool(consult7:*)" \
    "MCPTool(serena:*)"'

    # clap: full dev worker + MCPs + browser control
alias clap='claude \
  --allow-dangerously-skip-permissions \
  --permission-mode dontAsk \
  --allowedTools \
    "Bash(workspace_only:true)" \
    "Edit" \
    "Write" \
    "Read" \
    "WebSearch" \
    "TodoRead" \
    "TodoWrite" \
    "Grep" \
    "Glob" \
    "LS" \
    "WebFetch" \
    "NotebookEdit" \
    "MCPTool(zen:*)" \
    "MCPTool(context7:*)" \
    "MCPTool(consult7:*)" \
    "MCPTool(serena:*)" \
    "MCPTool(playwright:*)"'









## Claude aliases very specifically

# ─── REFERENCE ────────────────────────────────────────────────────────────────
# context7 tools:    resolve-library-id, get-library-docs
# zen tools:         chat, thinkdeep, planner, consensus, codereview, debug,
#                    analyze, refactor, tracer, testgen, secaudit, docgen,
#                    precommit, challenge, listmodels, version
# serena READ tools: list_dir, find_file, search_for_pattern, get_symbols_overview,
#                    find_symbol, find_referencing_symbols, read_memory,
#                    list_memories, check_onboarding_performed, onboarding,
#                    think_about_collected_information, think_about_task_adherence,
#                    think_about_whether_you_are_done, initial_instructions
# serena WRITE tools: replace_symbol_body, insert_after_symbol, insert_before_symbol,
#                    rename_symbol, write_memory, delete_memory, edit_memory
# playwright tools:  browser_navigate, browser_click, browser_type, browser_screenshot,
#                    browser_wait, browser_evaluate, browser_close (and others)
# consult7 tools:    consult (single tool)
# ──────────────────────────────────────────────────────────────────────────────

# cla: full dev worker, no MCPs (unchanged)
alias cla='claude \
  --allow-dangerously-skip-permissions \
  --permission-mode dontAsk \
  --allowedTools \
    "Bash(workspace_only:true)" \
    "Edit" "Write" "Read" \
    "WebSearch" "WebFetch" \
    "TodoRead" "TodoWrite" \
    "Grep" "Glob" "LS" \
    "NotebookEdit"'

# clar: read-only reviewer, no MCPs (unchanged)
alias clar='claude \
  --allow-dangerously-skip-permissions \
  --permission-mode dontAsk \
  --allowedTools \
    "Bash(git log:*)" "Bash(git diff:*)" \
    "Bash(git show:*)" "Bash(git status:*)" \
    "Read" "WebSearch" "WebFetch" \
    "TodoRead" "Grep" "Glob" "LS" \
    "NotebookEdit"'

# clam: full dev worker + all MCPs (no playwright)
alias clam='claude \
  --allow-dangerously-skip-permissions \
  --permission-mode dontAsk \
  --allowedTools \
    "Bash(workspace_only:true)" \
    "Edit" "Write" "Read" \
    "WebSearch" "WebFetch" \
    "TodoRead" "TodoWrite" \
    "Grep" "Glob" "LS" \
    "NotebookEdit" \
    "MCPTool(zen:*)" \
    "MCPTool(context7:*)" \
    "MCPTool(serena:*)" \
    "MCPTool(consult7:*)"

# clarm: read-only reviewer + read-only MCPs (no serena writes, no playwright)
alias clarm='claude \
  --allow-dangerously-skip-permissions \
  --permission-mode dontAsk \
  --allowedTools \
    "Bash(git log:*)" "Bash(git diff:*)" \
    "Bash(git show:*)" "Bash(git status:*)" \
    "Read" "WebSearch" "WebFetch" \
    "TodoRead" "Grep" "Glob" "LS" \
    "NotebookEdit" \
    "MCPTool(context7:resolve-library-id)" \
    "MCPTool(context7:get-library-docs)" \
    "MCPTool(zen:chat)" \
    "MCPTool(zen:thinkdeep)" \
    "MCPTool(zen:codereview)" \
    "MCPTool(zen:debug)" \
    "MCPTool(zen:analyze)" \
    "MCPTool(zen:secaudit)" \
    "MCPTool(zen:challenge)" \
    "MCPTool(serena:list_dir)" \
    "MCPTool(serena:find_file)" \
    "MCPTool(serena:search_for_pattern)" \
    "MCPTool(serena:get_symbols_overview)" \
    "MCPTool(serena:find_symbol)" \
    "MCPTool(serena:find_referencing_symbols)" \
    "MCPTool(serena:read_memory)" \
    "MCPTool(serena:list_memories)" \
    "MCPTool(serena:initial_instructions)" \
    "MCPTool(consult7:consult)"'

# clap: full dev worker + all MCPs + playwright
alias clap='claude \
  --allow-dangerously-skip-permissions \
  --permission-mode dontAsk \
  --allowedTools \
    "Bash(workspace_only:true)" \
    "Edit" "Write" "Read" \
    "WebSearch" "WebFetch" \
    "TodoRead" "TodoWrite" \
    "Grep" "Glob" "LS" \
    "NotebookEdit" \
    "MCPTool(zen:*)" \
    "MCPTool(context7:*)" \
    "MCPTool(serena:*)" \
    "MCPTool(consult7:*)"


## Codex way
all mcp tools are in ~/.codex/config.toml
Mcp servers get added there automatically when: codex mcp add.
You can change the settings using the -c flag.

alias coxm='codex --search -a on-failure --sandbox workspace-write \
  -c mcp_servers.playwright.enabled=false'








## Old:


MCP (Model Context Protocol) Servers

If servers need to be run for the MCP setup, I would like that to be done through docker.

I also want very simple instructions for how to make my claude code session then work with these MCP servers and how to set everything up.
If it is possible, I want a script for how to set everything up.
I am on WSL.

 - I want claude code to have web search (if it is not included from the start).
 - How to create custom MCP, and how will Claude Code know when it is useful to call it
 - Zen MCP using OpenRouter and using the google gemini api (as it is free, if i remember correctly) ( https://github.com/BeehiveInnovations/zen-mcp-server)
 - maybe additional websearch integration (like maybe having a cheap fast model search a bunch of pages and get exactly the relevant data)
  - Google Keep MCP
  - GitHub MCP for project planning
  - Atlassian CLI for Jira ticket creation and reading existing tickets

If possible, but not at all necessary, we would also enjoy having these MCP servers set up:

https://github.com/BeehiveInnovations/zen-mcp-server
https://github.com/upstash/context7
https://github.com/microsoft/playwright-mcp
https://github.com/szeider/consult7
https://github.com/SuperClaude-Org/SuperClaude_Framework
https://github.com/oraios/serena





