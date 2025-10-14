



# wsl ease of use
windows_username=$1
alias wsl='cd /mnt/c/Users/'$windows_username'/Desktop/WSL'
wsl

# main dev aliases
alias m='make'
alias t='task'

# git aliases
alias g='git'
alias s='git add . && git commit -m "autosave" && git push'
alias p='git push'
alias gs='git status'
alias gp='git pull'
alias ga='git add .'
alias gcm='git commit -m'
alias grm='git rebase origin main'
# alphabetically ordered:
alias gc='git commit'
alias gca='git commit --amend --no-edit'
alias gcl='git clone'
alias gf='git fetch --all --prune --progress'
alias gri='git rebase -i'
alias grc='git rebase --continue'
alias grmc='git rm -r --cached .'


# git connect to origin remote repo
alias gcon1='git init && git add . && git commit -m "Initial commit" && git remote add origin' # add your repo SSH URL after this command
alias gcon2='git remote -v && git branch -M main && git push -u origin main && git push'


# conda aliases
alias cn='conda'
alias ca='conda activate'
alias ccr='conda create --name'
alias cexp='conda env export > environment.yml'
alias ccrf='conda env create -f environment.yml'

# other dev aliases
alias c='code'
alias cx='code .'
alias pm='python3 -m'
alias d='docker'
alias dc='docker-compose'
alias pp='poetry run' # nice for short scripts you define in pyproject.toml
alias gssh='ssh-keygen -t ed25519 -C example@gmail.com
cat ~/.ssh/id_ed25519.pub
ssh -T git@github.com
yes' # perhaps use your actual     # ssh keygen for github    # newlines cannot automatically confirm the keygen choices. I tried.


# LLM CLI stuff
alias cla='claude --dangerously-skip-permissions --allowedTools Bash,Read,Glob,Grep,WebFetch,WebSearch,TodoWrite,Task,BashOutput,KillShell'
alias cox='codex --search -a on-failure --sandbox workspace-write'
alias coxr='codex --search -a never --sandbox read-only'


# random aliases
alias farmer='cd /mnt/c/Users/'$windows_username'/AppData/LocalLow/TheFarmerWasReplaced/TheFarmerWasReplaced/Saves/Claude'