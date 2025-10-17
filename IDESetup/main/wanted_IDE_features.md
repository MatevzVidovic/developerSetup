

Many of these settings are present in Goland. I want these settings set up in VScode.
I want these settigns to be set up using some sort of settings.json (so i can just paste them in).
Some of these features are to be supported using plugins.
The desired settings should use alt, so they can work on Windows and Ubuntu.



## Keybinding settings:

### Search:
alt f, arrow up/down to move along the instances, esc to close
alt f, alt r (open replace field), tab (move to replace field), (button for replace and replace all), esc to close
alt shift f to search the contents of all files in the project. In this search, I want to be able to set the search scope (opened files, in a specific directory, etc.)
Shift shift to search file names and open any file in the project

### Other
alt J for moving to previous cursor position
and alt K   for moving to next cursor position
alt b for moving to uses or definition of the thing where the cursor is
alt arrowLeft and alt arrowRight to move to tab to the left and to the right
alt 1/2/3/... to move to the tab with that number.
alt shift c to copy the absolute path of the file in the tab i currently have open
alt shift E and alt shift R to collapse or expand everything in the current tab
alt E and alt R to collapse or expand the part of code that the cursor is on, or collapse the part of code that is currently selected


alt K  commenting lines, and uncommenting them if they are already comments
alt shift K uncommenting all selected lines

Alt B to refactor name of variable the cursor is on.

Alt G to jump into left sidebar in the filetree.
When I am in it:
Right arrow to open the dir I am on, and left arrow to close the dir I am in. Up and down arrows to navigate it.
Enter to open the file. 
Ctrl shift n to make new dir, alt dir n to make new file.




## Other wanted features:

alt shift P to run commands I want (like linter autofixers)

I want to have everything collapsed automatically when I open a file

Double click on tab to open it in filetree to the side

Automatic definition peek: when hovering over sth, you see its definition and available attributes and fns


Save hooks: like always do lint autofix on save.




## Already exist:

F2 for renaming a file, and refactoring where the name is used

ctrl J closes and opens and closes bottom panel (terminal, debug console, etc)


Shadowing detection: Variables redefined in inner scopes get green coloring
Scope showing: when in an fn in a for loop in an if statement, and you cant see the fn signature, for loop start, if start, zou get them on the top of the page. So you exactly know what scope you are in.




Line heatmap, based on how old of a commit they belong to:

GitLens has Heatmap - where lines changed in more recent commits are brighter).
Changes from recent commits: to not only see what is changed in the staging area, but to be able to toggle for e.g. 2 last commits which lines were changed (helps you navigate to relevant parts of code a lot when working with many commits on the same feature change

For single file heatmap, you open user settings.json, (in ctrl + shift + P), 
then add:
    "gitlens.heatmap.toggleMode": true,
Then do ctrl shift P again, and use:
GitLens: Toggle File Heatmap
Try this too:  Toggle File Blame, Toggle File Changes

To always have Heatmap on, you do:
in settings.json (ctrl shift P, then User Defined (JSON) sth sth):
    "gitlens.modes": {
        "alwaysHeatmap": {
        "name": "Heatmap Always",
        "annotations": "heatmap"
        }
    },
    "gitlens.mode.active": "alwaysHeatmap",
    "gitlens.heatmap.locations": ["gutter", "overview"],
    "gitlens.heatmap.fadeLines": false,  
    "gitlens.heatmap.ageThreshold": 90,
    "gitlens.heatmap.hotColor": "#ff7043",
    "gitlens.heatmap.coldColor": "#4fc3f7",

Most settings are self-explanatory.
fadeLines is literally about lines gaining opacity the older they are if it is set to true. Literally text is less seeable.
ageThreshold is in days. Gitlens splits lines into the cold and hot bucket.
Cold lines get cold color, hot lines get hot color.
Inside each bucket, it builds quantiles.
The later the quantile lines have more saturated color on the side, and are less faded.
By default, ageThreshold is 90 days. I might like having less so I get more granularity in the recent changes.











