



# wsl ease of use
windows_username=$1
alias wsl='cd /mnt/c/Users/'$windows_username'/Desktop/WSL'
wsl

# main dev aliases
alias m="make"
alias t="task"

# git aliases
alias g='git'
alias s='git add . && git commit -m "autosave" && git push'
alias p='git push'
alias gs='git status'
alias gp='git pull'
alias ga='git add .'
alias gcm='git commit -m'
# alphabetically ordered:
alias gc='git commit'
alias gca='git commit --amend --no-edit'
alias gcl='git clone'
alias gf='git fetch --all --prune --progress'
alias gri='git rebase -i'


# other dev aliases
alias c='code .'
alias ca="conda activate"
alias pm="python3 -m"
alias d='docker'
alias dc='docker-compose'
alias pp="poetry run" # nice for short scripts you define in pyproject.toml



# LLM CLI stuff
alias cla="claude --dangerously-skip-permissions --allowedTools Bash,Read,Glob,Grep,WebFetch,WebSearch,TodoWrite,Task,BashOutput,KillShell"
alias cox="codex --search -a on-failure --sandbox workspace-write"
alias coxr="codex --search -a never --sandbox read-only"


# random aliases
alias farmer='cd /mnt/c/Users/'$windows_username'/AppData/LocalLow/TheFarmerWasReplaced/TheFarmerWasReplaced/Saves/Claude'