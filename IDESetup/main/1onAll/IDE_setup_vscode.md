




## Setup




### Reload VScode

Reload VS Code after editing settings.json/keybindings.json to ensure all keybindings stick.

ctrl + shift + p   and then pick  Developer: Reload Window


### PUML in md setup

To have puml rendering you usually need to install some java stuff and GraphViz or what is it and all this stuff.
It sucks.

Rather, have puml in an extension (like markdown-preview-enhanced)
and give it a URL to an external puml display server and it works like magic.
In settings.json:

    "markdown-preview-enhanced.plantumlServer": "https://www.plantuml.com/plantuml/proxy?src=",


### Explanations


  Search Workflow

  - Inside the editor find widget (Alt+F), up/down arrows continue jumping through matches; Esc closes it.
  - For project search (Alt+Shift+F), use the search view’s files to include/exclude boxes or click the ... menu
    to scope to the current folder or opened editors.
  - Install the Marketplace extension “Double Shift” (or similar) to make the Shift Shift chord launch Quick
    Open.

  Explorer & Tabs

  - With workbench.files.action.focusFilesExplorer on Alt+G, the explorer takes focus; arrow keys and Enter
    already expand/collapse/open as desired.
  - To keep the current file highlighted in the tree, set "explorer.autoReveal": true in settings.json.
  - There’s no built-in “double-click tab to reveal side explorer”; closest option is to bind
    workbench.files.action.showActiveFileInExplorer (e.g., to alt+shift+.) or use an extension such as “Reveal
    Active File In Sidebar on Double Click”.

  Automatic Folding

  - VS Code does not automatically fold every region on open. Options:
      1. Use an extension like “Automatic Fold” or “Auto Fold Code” and configure it to fold at a chosen level
         on file open.
      2. Add a workspace tasks.json command that runs editor.foldAll on file open via a macro extension (e.g.,
         “Macros” by geddski) and bind it to onWillSaveTextDocument or a convenient shortcut.

  Hover & Peek

  - Enable richer hover detail with:

  "editor.hover.enabled": true,
  "editor.hover.delay": 200,
  "editor.hover.sticky": true,
  "editor.foldingStrategy": "auto"

  - Many language extensions (TypeScript, Python, etc.) already show definition/attributes on hover; ensure they
    are installed and IntelliSense is active.





#### Explanation of folding keybindings

Why does
  { "key": "alt+shift+e", "command": "editor.foldRecursively", "when": "editorTextFocus && editorHasSelection" },
not fold all selected lines recursively, but only the first one?
Only if the selection started on a foldable line, that line gets folded, but nothing else.

Because
fold commands in VS Code act on the primary cursor, not on the whole selection. 
So with a range selected, editor.fold / editor.foldRecursively behave as if the cursor were at the start of that selection.

To fold all selected lines recursively, we need to create a custom command that places a cursor at the end of each selected line, folds at each cursor, then returns to a single cursor.





### Global settings.json

<!-- 

// Enable details when hovering over fns and objs - already exists in many language extensions
"editor.hover.enabled": true,
"editor.hover.delay": 200,
"editor.hover.sticky": true,
"editor.foldingStrategy": "auto"

// Mouse scroll sensitivity (kind of depends on your screen resolution, size, and mouse DPI)
"editor.mouseWheelScrollSensitivity": 3,
"editor.fastScrollSensitivity": 10,
"workbench.list.mouseWheelScrollSensitivity": 1,
"workbench.list.fastScrollSensitivity": 5,
"terminal.integrated.mouseWheelScrollSensitivity": 1,
"terminal.integrated.fastScrollSensitivity": 5,


Set up multiline code folding using the multicommand extension in vscode:
-->


"multiCommand.commands": [
  {
    "command": "multicommand.fold.eachSelectedLineRecursively",
    "sequence": [
      "editor.action.insertCursorAtEndOfEachLineSelected",  // 1 caret per line
      "editor.foldRecursively",                             // fold at every caret
      "cancelSelection",                                    // go back to single caret
      "removeSecondaryCursors"
    ]
  },
  {
    "command": "multicommand.unfold.eachSelectedLineRecursively",
    "sequence": [
      "editor.action.insertCursorAtEndOfEachLineSelected",
      "editor.unfoldRecursively",
      "cancelSelection",
      "removeSecondaryCursors"
      ]
  }
],


### Extensions:

- "multi-command (by ryuta46)": Allows defining custom commands that chain multiple commands together.
One of the more lightweight macro extensions.
You can chain any commands you see in the Command Palette.
Just define chains in settings.json, then bind them to keys in keybindings.json.

- extension “Double Shift” (or similar) to make the Shift Shift chord launch Quick Open.






### Tasks & Save Hooks

You can either:

- set things up in your (repo_root).vscode/settings.json and (repo_root).vscode/tasks.json
This is nice when you have general standards in your, so you share formating and linting settings and so you have a consistent style and also there aren't unnecessary formating changes in git diffs.

- set things up in your global tasks and settings:

ctrl + shift + p  Tasks: Open User Tasks,   open tasks.json, add tasks.
Run with  alt + shift + P

ctrl + shift + p    user settings json, settings.json
Add the file-ending specific formatings and lint autofixers (usually calling vscode extensions, but potentially even running bash commands in the later "More complex bash commands" section)

[vue]": {
    "editor.formatOnSave": true,
    "editor.defaultFormatter": "esbenp.prettier-vscode"
},





#### Tasks

  - Define a task in .vscode/tasks.json:

  {
    "version": "2.0.0",
    "tasks": [
      {
        "label": "Lint Fix",
        "type": "shell",
        "command": "npm run lint -- --fix",
        "problemMatcher": []
      }
    ]
  }

  - Alt+Shift+P now opens the task picker when bound to workbench.action.tasks.runTask.


#### Save Hooks

- In .vscode/settings.json, configure it like:

#### Basic configuarable commands

"editor.codeActionsOnSave": {
  "source.fixAll.eslint": "explicit"
},
"editor.formatOnSave": true

(Adjust to your tool, e.g., source.fixAll for TSLint/Rust/etc.)

#### More complex bash commands

- Install “Run on Save” (emeraldwalk.runonsave) or “Command Runner”.
    {
      "emeraldwalk.runonsave": {
        "commands": [
          {
            "match": "src/.*\\.ts$",
            "cmd": "npm run lint -- --fix"
          }
        ]
      }
    }
    (Command runs from the workspace root; tweak the glob and command as needed.)


  - Run lint automatically on save with settings.json:




### Heatmap

Line heatmap, based on how old of a commit they belong to:

GitLens has Heatmap - where lines changed in more recent commits are brighter.
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

And possibly you nonetheless still have to do:
Ctrl Shift P, GitLens: Toggle File Heatmap

Most settings are self-explanatory.
fadeLines is literally about lines gaining opacity the older they are if it is set to true. Literally text is less seeable.
ageThreshold is in days. Gitlens splits lines into the cold and hot bucket.
Cold lines get cold color, hot lines get hot color.
Inside each bucket, it builds quantiles.
The later the quantile lines have more saturated color on the side, and are less faded.
By default, ageThreshold is 90 days. I might like having less so I get more granularity in the recent changes.












