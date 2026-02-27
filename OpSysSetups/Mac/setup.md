

## Intall Raycast



## TRY OUT HAMMERSPOON - seems kind of like ahk but for macos


Untested example by claude:

local function moveWindow(unit)
    local win = hs.window.focusedWindow()
    if win then win:moveToUnit(unit) end
end

hs.hotkey.bind({"fn", "ctrl"}, "left",  function() moveWindow(hs.layout.left50) end)
hs.hotkey.bind({"fn", "ctrl"}, "right", function() moveWindow(hs.layout.right50) end)
hs.hotkey.bind({"fn", "ctrl"}, "up",    function() moveWindow(hs.layout.maximized) end)

Paste this into your ~/.hammerspoon/init.lua, reload config, and fn+ctrl+arrows will instantly snap any focused window. No prompts, no waiting.

Note: fn as a modifier can be tricky on some Macs — if it doesn't work, swap "fn" for "alt" or {"ctrl", "alt"} which are more reliable.

### can hammerspoon also handle emit redirections, like making alt c be same as ctrl c?

hs.hotkey.bind({"alt"}, "c", function()
    hs.eventtap.keyStroke({"ctrl"}, "c")
end)


local altToCtrl = {"c", "v", "x", "z", "a", "s"}

for _, key in ipairs(altToCtrl) do
    hs.hotkey.bind({"alt"}, key, function()
        hs.eventtap.keyStroke({"ctrl"}, key)
    end)
end



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
