



## Quick Zsh setup (do first)

1. Install Zsh
```sh
 sudo apt update
 sudo apt install zsh -y
``` 

2. Install Oh My Zsh 
```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# answer y to overwriting (nothing is in it yet anyways)
# You can answer y to make it the default shell.
```

3. (not needed if already default shell) Set Zsh as Default Shell 
```sh
chsh -s $(which zsh)
```
You'll need to log out and back into WSL for this to take effect.

4. Install fzf

```sh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf 
~/.fzf/install

echo "[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh" >> ~/.zshrc
echo "source <(fzf --zsh)" >> ~/.zshrc | source ~/.zshrc

# Do y for all 3 questions.
# This will now create .fzf.zsh (as it sees you have zsh intalled)
```



## Alias setup:

Cd to here, then:
. setup.sh



## Vim motions inside Ubuntu/WSL terminal:

echo "
set -o vi" >> ~/.bashrc
source ~/.bashrc

echo "
bindkey -v" >> ~/.zshrc
source ~/.zshrc






## Continued ZSH setup:



2. Install Oh My Zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
This will:
- Clone Oh My Zsh to ~/.oh-my-zsh
- Create a new .zshrc configuration file
- Backup any existing .zshrc to .zshrc.pre-oh-my-zsh
- Ask if you want to change default shell to Zsh





(not needed) 5. Configure Oh My Zsh Theme & Plugins
Edit .zshrc to customize:
- Theme: Default is "robbyrussell", popular alternatives: "agnoster", "powerlevel10k"
- Plugins: Enable useful ones like:
- git (already enabled by default)
- zsh-autosuggestions (needs separate install)
- zsh-syntax-highlighting (needs separate install)
- fzf
- docker
- npm


6. Install Popular Plugin Extensions # Autosuggestions git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions # Syntax highlighting git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


7. Optional: Install Powerlevel10k Theme 
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

Then:
echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> ~/.zshrc



What You'll Get:
- Intelligent tab completion for commands, paths, and git
- Git branch info in your prompt
- Syntax highlighting as you type
- Command history with better search (Ctrl+R)
- Aliases and shortcuts for common tasks
- Extensible plugin system for additional features
- Beautiful themes with customizable prompts
Post-Installation:
- Restart WSL or run exec zsh to start using Zsh
- Run p10k configure if using Powerlevel10k theme
- Your bash history won't transfer automatically (can be imported if needed)