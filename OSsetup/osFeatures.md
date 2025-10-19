

MacOS has a lot of this.
I want these settings to be for windows and for the WSL terminal in windows.

I want this setup to be as simple as possible. I dont mind not having some features for the sake of simplicity.
I want the setup to, hopefully: only use one json-like file setup for the wsl terminal (the file can be as complicated as you want). I want to be able to just copy and paste these settings and have them work.

These are cmd commands.
On windows they should use ctrl, and also be duplicated to use alt.



## Terminal

Terminal migration (for my wsl terminal):


cmd U to delete the current line
cmd 1/2/3/... to move to the correct tab.
cmd arrowLeft/right to move in tabs
cmd t to open new tab
cmd w to close current tab
cmd f to search in the terminal
cmd shift t to open a new tab with the same cwd as the current tab

I want alt + c, alt+v, alt+x to do copy, paste, cut

(Done through plugins in the wsl terminal)
I want the terminal to have vim commands.
I want it to have fzf functionality.




I keep the default terminal as powershell.
Because when you are in file explorer, you do right click and open terminal, it opens powershell in the windows terminal.
If you have some other terminal as default, it won't work.

But
In the terminal keybinding settings, you can set ctrl shift t to open a new tab with ubuntu profile. (or ctrl t, or alt t, whatever you want).




cmd shift n to make new directory (if in file explorer)
cmd shift backspace to be delete










I am moving from mac to windows, and mainly to WSL in windows
  I want to have all of the mentioned features
  Do deep research on how to set them up, preferably through implementing the changes through setting some JSON
  file or any sort of file where I can paste the code in and have it work

Very important: I want this setup to be as simple as possible. I dont mind if you do not implement some features, just tell me what you didnt implement.
I want you to, hopefully make one json-like file for seting up the windows keybindings 

Also very important:
Below are the mac commands which use cmd.
Many of these commands already work on windows when you use ctrl instead.
Keep those commands it hey work - otherwise make a new ctrl + key command that does that.
Also, make it so that for all these cases alt + key maps to ctrl + key.


F11 should hide the taskbar and the bar with tabs (for browsers).
(It already does that on windows)

Add non-fn fn capabilities:
Sound up, down, mute. 
Play/pause (for the most recent media)
Brightness up, down.


For terminal:
fzf search is insanely useful and necessary
Oh My Zsh (showing git branch, num of changed files, num of staged files, num of stashes, error of previous command, and being able to just click and have the whole last command selected for copy and even having it automaticallty copied when text is selected)

To not mess with the LLM:
(already winkey arrows on windows) fn ctrl arrows to position window tiling on part of screen or fullscreen


## System important:

### Window tiling (this already works on windows with winkey + arrowkeys so no need to change it)
- make cmd + arrowLeft/right position the current window into that tiling (left or right)
- make cmd + arrowUp put the current window to fullscreen,



cmd shift n to make new directory (if in file explorer)


Saved clipboard history, easily accessible to get back to the current clipboard area

Better system search



Firefox important:
Disable "Switch to tab". When you do ctrl t, do arrow down and you will see starred and recent urls. When you click them, it should open a new instance, not switch to an existing tab. This allows you to not touch the mouse.
