

Many of these settings are present in Goland. I want these settings set up in VScode.
I want these settigns to be set up using some sort of settings.json (so i can just paste them in).
Some of these features are to be supported using plugins.
These are for MacOS (Using cmd). Should use ctrl and additionally have the commands be duplicated for the alt command.


cmd f, arrow up/down to move along the instances, esc to close
cmd f, cmd r, tab (to move to replace field), (button for replace and replace all), esc to close
Cmd shift f to search the contents of all files in the project, and to be able to set scope (opened files, or in a specific directory)
Shift shift to search and open any file in the project

cmd [ and cmd ]   for moving to past cursor positions
cmd b for moving to uses or definition of the thing where the cursor is
cmd shift [ and cmd shift ] to move to tab to the left and to the right
cmd shift P to apply linter autofixers
cmd shift c to copy the absolute path of the file in the tab i currently have open
cmd shift - and cmd shift = to collapse or expand everything in the current tab
To have everything collapsed when I open a file
Cmd - and cmd = to collapse or expand the part of code that the cursor is on, or collapse the part of code that is currently selected
cmd /  commenting lines, and uncommenting them if they are already comments
cmd shift / uncommenting all celected lines

Right-click + refactor/rename to change the name of a variable
But I want this to also be done by Alt + m (as in renaMe)


Not in goland, but I want it:
Double click on tab to open it in filetree to the side
cmd 1/2/3/... to move to the correct tab.
cmd arrowLeft/right to move in tabs
F2 for renaming a file, and refactoring where the name is used
Keybinding to jump into filetree. Right arrow to open the dir I am on, and left arrow to close the dir I am in. Up and down arrows to navigate it. Enter to open the file. Ctrs shift n to make new dir, alt dir n to make new file.
alt + M to toggle vim extension on and off


Keybinding side-effects i want to be different:
cmd z being able to go as far back as you want (not limited by last save)
cmd s not expanding all code (in goland go fmt always happens on save)

Testing and debugging support:
fn F<sth> to run the last tast i ran
To set tests cwd, program flags, command flags and have that persist, and to een have a preset for the project that applies when running every tests the first time
Running the unit test by clicking on the play button next to its definition
Running the debugger directly on the unit tests
Running a unit test with coverage (seeing how many times each line was hit)

Git commit integration (marking what i want to put in the commit, open the diffs by clicking on the files in the git tab, jump to source if i right-click and choose that on the file in the commit view)
Easily cherry picking commits
(GitLens has Heatmap - where lines changed in more recent commits are brighter).
Changes from recent commits: to not only see what is changed in the staging area, but to be able to toggle for e.g. 2 last commits which lines were changed (helps you navigate to relevant parts of code a lot when working with many commits on the same feature change)


Shadowing detection: Variables redefined in inner scopes get green coloring
Scope showing: when in an fn in a for loop in an if statement, and you cant see the fn signature, for loop start, if start, zou get them on the top of the page. So you exactly know what scope you are in.
Save hooks: like always do lint autofix on save.
Automatic definition peek: when hovering over sth, you see its definition and available attributes and fns









