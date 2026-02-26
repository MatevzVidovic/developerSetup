



# Put fns to the top


## With claude, we cant easily enable and disable mcps in the commandline.
## You have to do     --strict-mcp-config --mcp-config '{"mcpServers":{}}' \
## So you have to build this json, which means you need jq command and complex logic to build it. Its not worth it.
## So we simply have all or nothing.
## In _mcp fns we simply only make certain mcp servers allowed (so we don't have context poisoning from them automatically)
## But the mcp servers will still get run.

CLA_RW_PERMS=(
    # "Bash(workspace_only:true)" # messed everyhting up - constantly needed permission for stuff even in this workspace (i think bc of using abs paths)
    "Bash(*)"
    "Edit" "Write" "Read"
    "WebSearch" "WebFetch"
    "TodoRead" "TodoWrite"
    "Grep" "Glob" "LS"
    "Task" "BashOutput" "KillShell"
    "NotebookEdit"
  )

CLA_READ_PERMS=(
      "Bash(git log:*)" "Bash(git diff:*)" 
      "Bash(git show:*)" "Bash(git status:*)" 
      "Read" "WebSearch" "WebFetch" 
      "TodoRead" "Grep" "Glob" "LS" 
      "Task" "BashOutput" "KillShell" 
      "NotebookEdit" 
)


cla() {
  set -x  # prints every command with expanded args
  claude \
    --allow-dangerously-skip-permissions \
    --permission-mode dontAsk \
    --allowedTools \
      "${CLA_RW_PERMS[@]}" \
      "${tools[@]}" \
    --strict-mcp-config --mcp-config '{"mcpServers":{}}'

  set +x
}

clar() {
  set -x  # prints every command with expanded args
  claude \
    --allow-dangerously-skip-permissions \
    --permission-mode dontAsk \
    --allowedTools \
      "${CLA_READ_PERMS[@]}" \
      "${tools[@]}" \
	--strict-mcp-config --mcp-config '{"mcpServers":{}}'

  set +x

}

# Dev (workspace write)
cla_mcp() {

  set -x  # prints every command with expanded args
  local tools=()
  local s
  for s in "$@"; do
    tools+=("MCPTool(${s}:*)")
  done

  claude \
    --allow-dangerously-skip-permissions \
    --permission-mode dontAsk \
    --allowedTools \
      "${CLA_RW_PERMS[@]}" \
      "${tools[@]}"
    
    set +x
}

# Review (read-only)
clar_mcp() {
  set -x  # prints every command with expanded args
  local tools=()
  local s
  for s in "$@"; do
    tools+=("MCPTool(${s}:*)")
  done

  claude \
    --allow-dangerously-skip-permissions \
    --permission-mode dontAsk \
    --allowedTools \
      "${CLA_READ_PERMS[@]}" \
      "${tools[@]}" 
    
  set +x
}



_codex_with_mcp() {
  local approval="$1"; shift
  local sandbox="$1"; shift
  local args=(codex --search -a "$approval" --sandbox "$sandbox"
    -c "sandbox_workspace_write.network_access=true"
  )
  
  # Enable only the listed MCP servers (defaults should be enabled=false in config.toml)
  for s in "$@"; do
    args+=(-c "mcp_servers.${s}.enabled=true")
  done

  "${args[@]}"
}




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

## With claude, mcp servers still run! They just aren't in allowed tools.

alias cla='cla'
alias clar='clar'

alias clam='cla_mcp context7 serena'
alias clarm='clar_mcp context7 serena'
alias clam1='cla_mcp context7 serena zen consult7'
alias clarm1='clar_mcp context7 serena zen consult7'

alias cox='_codex_with_mcp never workspace-write'
alias coxr='_codex_with_mcp never read-only'

alias coxm='cox context7 serena'
alias coxrm='coxr context7 serena'
alias coxm1='cox context7 serena zen consult7'
alias coxrm1='coxr context7 serena zen consult7'





# show aliases
shal() {
    cat << 'EOF'

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

## With claude, mcp servers still run! They just aren't in allowed tools.

alias cla='cla'
alias clar='clar'

alias clam='cla_mcp context7 serena'
alias clarm='clar_mcp context7 serena'
alias clam1='cla_mcp context7 serena zen consult7'
alias clarm1='clar_mcp context7 serena zen consult7'

alias cox='_codex_with_mcp never workspace-write'
alias coxr='_codex_with_mcp never read-only'

alias coxm='cox context7 serena'
alias coxrm='coxr context7 serena'
alias coxm1='cox context7 serena zen consult7'
alias coxrm1='coxr context7 serena zen consult7'


EOF
}

# ======================================================================


