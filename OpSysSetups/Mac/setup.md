

## Intall Raycast




## Clone this repo into ~ to make things easiest

## Quick Zsh setup (do first)
 

1. Install Oh My Zsh 


!!! probably with brew

<!-- ```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# answer y to overwriting (nothing is in it yet anyways)
# You can answer y to make it the default shell.
``` -->

2. Install fzf

!!! probably with brew

<!-- ```sh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf 
~/.fzf/install

echo "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" >> ~/.zshrc
echo "source <(fzf --zsh)" >> ~/.zshrc | source ~/.zshrc

# Do y for all 3 questions.
# This will now create .fzf.zsh (as it sees you have zsh intalled)
```
 -->



## Alias setup:

Cd to here, then:

sourceAliases="
source ~/developerSetup/OpSysSetups/LinuxAndWSL/LinuxTerminal/aliasesAndSuch.sh"

echo $sourceAliases >> ~/.zshrc



## Vim motions inside terminal:

echo "
bindkey -v" >> ~/.zshrc
source ~/.zshrc
