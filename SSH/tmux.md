


# Tmux


It has 3 great features:
- Offers persistent sessions even if ssh connection breaks (like the screen tool). 
This is great for persistence despite ssh connections breaking. Especially great for long-running processes. 
Also, you can ssh from different devices and enter the same terminal session.
- Tmux panes (the textual overlay)
- Has special keybindings (ctrl b + sth) and you can define your own.



The pane splitting is done textually (like how htop displays data actively)
Its not a gui app

Tmux is just an overlay. Your shell is exacly the same.
The windows terminal keybindings work exactly the same.




## Basics

```sh

sudo apt update
sudo apt install tmux -y


# start it:
tmux

# detach from tmux:
Ctrl + b, then d

# Reattach to previous session:
tmux attach

# See existing sessions:
tmux ls

# all sessions are persistent as long as the computer is turned on.
# After you turn it off, all sessions are deleted.

# named sessions:
tmux new -s work
tmux attach -t work

tmux kill-session -t work

# Kill all sessions:
tmux kill-server
# or from inside tmux:
exit
```














## Config:

```sh
nano ~/.tmux.conf

# --- General ---
set -g mouse on                 # Enable mouse support (drag, scroll, resize)
set -g history-limit 10000      # Bigger scrollback
set -g default-terminal "screen-256color"  # Better colors

# --- Prefix ---
unbind C-b
set -g prefix C-a               # Use Ctrl + a instead of Ctrl + b (easier)
bind C-a send-prefix

# --- Splits ---
bind | split-window -h          # Ctrl+a + |  = vertical split
bind - split-window -v          # Ctrl+a + -  = horizontal split
unbind '"'
unbind %

# --- Pane navigation ---
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R
bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"

# --- Status bar ---
set -g status-bg colour236
set -g status-fg white
set -g status-left "#[fg=green]#S #[fg=white]|"
set -g status-right "#[fg=cyan]%Y-%m-%d %H:%M"

# --- Windows ---
setw -g automatic-rename on
set -g renumber-windows on

# --- Shell ---
set -g default-shell /usr/bin/zsh




tmux source ~/.tmux.conf
```



## What if I don't have zsh in tmux but regular bash?

If you see plain bash inside tmux, you can fix it with:
tmux set-option -g default-shell /usr/bin/zsh
and put that line in your ~/.tmux.conf.
