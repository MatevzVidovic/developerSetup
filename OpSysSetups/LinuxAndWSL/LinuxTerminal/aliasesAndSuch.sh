


# main dev aliases
alias m='make'
alias t='task'

# git aliases
alias g='git'
alias s='git add . && git commit -m "autosave" && git push'
alias gs='git status'
alias gpl='git pull'
alias gph='git push'
alias gphf='git push --force-with-lease'
alias ga='git add'
alias gam='git add . && git commit --amend --no-edit'
alias gax='git add .'
alias gcmm='git commit -m'
alias gf='git fetch --all --prune --progress'
alias grbm='git rebase origin/main'
# alphabetically ordered:
alias gcm='git commit'
alias gcma='git commit --amend --no-edit'
alias gcl='git clone'
alias grbi='git rebase -i'
alias grbc='git rebase --continue'
alias grmc='git rm -r --cached .'
alias gst='git stash'
alias gstu='git stash -u'


# git connect to origin remote repo
alias gcon1='git init && git add . && git commit -m "Initial commit" && git remote add origin' # add your repo SSH URL after this command
alias gcon2='git remote -v && git branch -M main && git push -u origin main && git push'


# conda aliases
alias cn='conda'
alias cna='conda activate'
alias cncr='conda create --name'
alias cnex='mkdir -p .conda && conda env export > .conda/environment.yml'
alias cnu='conda env update -f .conda/environment.yml'
# r for regular:
alias cnrex='conda env export > environment.yml'
alias cnru='conda env update -f environment.yml'

# other dev aliases
alias c='code'
alias cx='code .'
alias py='python3'
alias pym='python3 -m'
alias dr='docker'
alias drc='docker-compose'
alias pr='poetry run' # nice for short scripts you define in pyproject.toml
alias gssh='ssh-keygen -t ed25519 -C example@gmail.com
cat ~/.ssh/id_ed25519.pub
ssh -T git@github.com
yes' # perhaps use your actual     # ssh keygen for github    # newlines cannot automatically confirm the keygen choices. I tried.


# LLM CLI stuff
alias cla='claude --dangerously-skip-permissions --allowedTools Bash,Read,Glob,Grep,WebFetch,WebSearch,TodoWrite,Task,BashOutput,KillShell'
alias cox='codex --search -a on-failure --sandbox workspace-write'
alias coxr='codex --search -a never --sandbox read-only'


