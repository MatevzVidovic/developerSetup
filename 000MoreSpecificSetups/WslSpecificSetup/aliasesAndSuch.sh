



# wsl ease of use
windows_username=$1
alias wsl='cd /mnt/c/Users/'$windows_username'/Desktop/WSL'
wsl

# main dev aliases
alias m="make"
alias g='git'
alias s='git sp'
alias p='git push'
alias sp='s && p'

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