

MacOS has a lot of this.
I want these settings to be for windows and for the WSL terminal in windows.

I want this setup to be as simple as possible. I dont mind not having some features for the sake of simplicity.
I want the setup to, hopefully: only use one json-like file setup for the wsl terminal (the file can be as complicated as you want). I want to be able to just copy and paste these settings and have them work.

These are cmd commands.
On windows they should use ctrl, and also be duplicated to use alt.





Terminal migration (for my wsl terminal):
cmd U to delete the current line
cmd 1/2/3/... to move to the correct tab.
cmd arrowLeft/right to move in tabs
cmd t to open new tab
cmf f to search in the terminal
cmd shift t to open a new tab with the same cwd as the current tab 

I want alt + c, alt+v, alt+x to do copy, paste, cut

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




  macOS to Windows Migration
Cmd W to close tabs (browser, terminal, IDE)
Cmd Q to quit application completely (all windows)
Want sth like: Cmd E to quit the applications current window (not all firefox windows, and not just the current tab, but the current window)
winkey+alt+ arrowUp (ctrl arrowUp on mac) to open virtual desktops, and 
winkey+alt+arrowRight/left  (ctrl arrowRight/left on mac) to switch between them
cmd 1/2/3/... to move to tabs in the browser
cmd arrowLeft/right to move in tabs
cmd c, v, z, s, a, x, r, t, n
cmd shift z
(I want alt c, z, y, (shift+z)   to directly do copy, undo, redo, and redo, not just to map to ctrl c, z, y (shift+z) - becausee in the terminal, i e.g. dont want alt c to cause sigint).
CapsLock being escape (good for using vim)


on my windows computer I would like to make my numpad numbers and the operation symbols and the numlock area comma and enter when the numlock is off to actually be: 
1-9: ( { [ ~ / _ = | ´
/: )
*: }
-: ]
+: @
enter: ^
0: %
comma: & 



=================================

Hot corners:
Putting mouse into left bottom corner puts computer to sleep
Putting mouse into right bottom corner just locks it and turns off screen

Add non-fn fn capabilities:
Sound up, down, mute. 
Play/pause (for the most recent media)
Brightness up, down.

I want shift + arrowkeys to mark text word by word (like hot shift + ctrl + arrowkeys does).
And I want shift+ctrl+arrowkeys to mark text character by character (like how shift + arrowkeys does).

For terminal:
fzf search is insanely useful and necessary
Oh My Zsh (showing git branch, num of changed files, num of staged files, num of stashes, error of previous command, and being able to just click and have the whole last command selected for copy and even having it automaticallty copied when text is selected)

To not mess with the LLM:
(already winkey arrows on windows) fn ctrl arrows to position window tiling on part of screen or fullscreen

System important:
- For using virtual desktops: When searching for an app (winkey), that shoudlnt route you to an existing window (possibly in another virtual desktop). Make it just open the app. Or if nothing else, prevent it from switching virtual desktops, so it just "switches to it" in the background and you can then do ctrl n.
- Make winkey tab be just like alt tab.
- Make winkey arrowup be like what winkey tab was before.
- Make winkey arrowSide switch between virtual desktops.
- Make winkey space be the default search, just like only pressing winkey.

- Fn arrow up being page up, and down for PgDn
Its quite awesome that the new top of screen is exactly where bottom of line was previously. But also kinda annoying, because it disorients you in many cases.
So I want to make it so it moves only half a screen down.
- Fn arrow left going to start of line, and right to end of line.


In alt-tab disable the split-screen options (doesnt just show you windows you have open, but also combined tilings of certain windows. I dont like the unnecessary mess.)



Raycast - saved clipboard history (and better system search)

  GitLab to GitHub Migration

MR suggestions: marking what code should be replaced with what other code. And then being able to make a batch of those changes and make a commit diretly in the browser.
Thread comments: What still needs to be resolved is nicely apparent and you can go through all of them with one button.
Web IDE: being able to ctrl shift f in the project from some specific commit directly in the web (for seeing how sth worked in the past)


Firefox important:
Disable "Switch to tab". When you do ctrl t, do arrow down and you will see starred and recent urls. When you click them, it should open a new instance, not switch to an existing tab. This allows you to not touch the mouse.
