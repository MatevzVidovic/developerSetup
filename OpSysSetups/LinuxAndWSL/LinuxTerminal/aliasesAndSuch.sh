


# Setup of aliases

# ======================================================================

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
alias cnel="conda env list"
alias cna='conda activate'
alias cnd='conda deactivate'
alias cncr='conda create --name'
alias cnex='mkdir -p .conda && conda env export > .conda/environment.yml && conda env export --from-history > .conda/env-readable.yml'
alias cnu='conda env update -f .conda/environment.yml'
# r for regular:
alias cnrex='conda env export > environment.yml'
alias cnru='conda env update -f environment.yml'

# docker
alias dr='docker'
alias drc='docker-compose'
alias dru="docker compose up --build"
alias drd="docker compose down"
# alias dru="docker compose -f .docker/docker-compose.yml up --build"
# alias drd="docker compose -f .docker/docker-compose.yml down"
alias drcr="docker compose run --rm --service-ports" # <service_name_from_compose_yml> sh   # open single service as a shell.
# main observability
alias drps="docker ps"
alias drt="docker exec -it" # container-name sh  # or bash or zsh   # get terminal access to the running container  
alias drl="docker compose logs -f" # <optionally: service_name> to get logs for a specific service.
# all observability
alias drpsa="docker ps -a"    # also show stopped containers
alias drr="sudo service docker status" # is docker engine running on Linux?
alias drim="docker images"
alias drin="docker inspect" # <container_name_or_id>
alias drlf="docker logs -f" # <container_name_or_id>
# cleanup
alias drrmc="docker rm" # <container_id_or_name>   # removeing containers
alias drrmi="docker rmi" # <image_id_or_name>    # removing images
alias drp="docker system prune"    # prune what is unused
alias drpa="docker system prune -a"    # prune agressively - everything not currently used (except persistent volumes)
alias drpav="docker system prune -a --volumes"    # also removes volume contents for complete reset.

# other dev aliases
alias c='code'
alias cx='code .'
alias py='python3'
alias pym='python3 -m'
alias pr='poetry run' # nice for short scripts you define in pyproject.toml
alias gssh='# Have just one ssh key per (comp+os)
# The example@gmail.com is actually just an id for you to know what comp id this is refering to.
# So change it to sth like: matevz_desktop@windows or matevz_desktop@wsl_24_04_basic

ssh-keygen -t ed25519 -C example@gmail.com
cat ~/.ssh/id_ed25519.pub    # add this to github in settings/ssh keys
ssh -T git@github.com    # see if you can connect to github
yes' # perhaps use your actual     # ssh keygen for github    # newlines cannot automatically confirm the keygen choices. I tried.


# LLM CLI stuff
alias cla='claude --dangerously-skip-permissions --allowedTools Bash,Read,Glob,Grep,WebFetch,WebSearch,TodoWrite,Task,BashOutput,KillShell'
alias cox='codex --search -a on-failure --sandbox workspace-write'
alias coxr='codex --search -a never --sandbox read-only'

# ======================================================================


