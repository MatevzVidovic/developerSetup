
## Vim mode



### Some wanted features in Vim mode:

- make vim toggle (alt M)
- key repeat (pressed key keeps repeating) (windows vscode already has this)
- caps lock maps to esc
- make tab and shift tab work on a visual block, and on a selection in normal mode
- yank to clipboard
- add some char before and after a block


### Keybinding conflicts with Vim mode

Vim messes up a lot of keybindings (intercepts a lot of them).

Ctrl+C → Vim “cancel/escape” (not copy)
Ctrl+V → Vim visual block (not paste)
Ctrl+X → decrement number / other Vim ops (not cut)


So we have to take care of this stuff.