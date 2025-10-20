




## Setup

### Keybindings.json

  - Open File → Preferences → Keyboard Shortcuts (JSON) and drop in the mappings below (adjust any existing
    duplicates as needed):

[
  { "key": "alt+f",           "command": "editor.actions.find" },
  { "key": "alt+r",     "command": "editor.action.startFindReplaceAction" },
  { "key": "alt+shift+f",     "command": "workbench.action.findInFiles" },

  { "key": "shift shift",     "command": "workbench.action.quickOpen" },               // requires “Double Shift” extension

  { "key": "alt+h",           "command": "workbench.action.navigateBack" },
  { "key": "alt+l",           "command": "workbench.action.navigateForward" },
  { "key": "alt+b",           "command": "editor.action.referenceSearch.trigger" },
  { "key": "alt+shift+b",     "command": "editor.action.rename" },

  { "key": "alt+left",        "command": "workbench.action.previousEditor" },
  { "key": "alt+right",       "command": "workbench.action.nextEditor" },
  { "key": "alt+1",           "command": "workbench.action.openEditorAtIndex1" },
  { "key": "alt+2",           "command": "workbench.action.openEditorAtIndex2" },
  { "key": "alt+3",           "command": "workbench.action.openEditorAtIndex3" },
  { "key": "alt+4",           "command": "workbench.action.openEditorAtIndex4" },
  { "key": "alt+5",           "command": "workbench.action.openEditorAtIndex5" },
  { "key": "alt+6",           "command": "workbench.action.openEditorAtIndex6" },
  { "key": "alt+7",           "command": "workbench.action.openEditorAtIndex7" },
  { "key": "alt+8",           "command": "workbench.action.openEditorAtIndex8" },
  { "key": "alt+9",           "command": "workbench.action.lastEditorInGroup" },

  { "key": "alt+shift+c",     "command": "workbench.action.files.copyPathOfActiveFile" },

  { "key": "alt+shift+e",           "command": "editor.fold" }, // to fold all, just do alt+A, alt+shift+e
  { "key": "alt+shift+d",           "command": "editor.unfold" },
  { "key": "alt+shift+e",           "command": "editor.fold",
    "args": { "selectionLines": true },      "when": "editorTextFocus && editorHasSelection"    },
  { "key": "alt+shift+d",           "command": "editor.unfold",
    "args": { "selectionLines": true },      "when": "editorTextFocus && editorHasSelection"    },

  { "key": "alt+k",           "command": "editor.action.commentLine", "when": "editorTextFocus" },
  { "key": "alt+shift+k",     "command": "editor.action.removeCommentLine" },

  { "key": "alt+g",           "command": "workbench.files.action.focusFilesExplorer" },
  { "key": "ctrl+shift+n",    "command": "explorer.newFolder" },
  { "key": "alt+shift+n",     "command": "explorer.newFile" },

  { "key": "alt+shift+p",     "command": "workbench.action.tasks.runTask" }, // gives you choice of which task in tasks.json to run

  { "key": "alt+shift+.",     "command": "workbench.files.action.showActiveFileInExplorer" },  // to quickly reveal current file in explorer 



  { "key": "alt+m", "command": "toggleVim" }, // if using vim extension, toggle it on/off quickly


  // IDE terminal navigation and creation
  {
    "key": "ctrl+t",
    "command": "workbench.action.terminal.newWithCwd",
    "args": {
      "cwd": "${workspaceFolder}"
    },
    "when": "terminalFocus"
  },
  {
    "key": "ctrl+n",
    "command": "workbench.action.terminal.newWithCwd",
    "args": {
      "cwd": "${fileDirname}"
    },
    "when": "editorTextFocus"
  },
  {
    "key": "ctrl+right",
    "command": "workbench.action.terminal.focusNext",
    "when": "terminalFocus"
  },
  {
    "key": "ctrl+left",
    "command": "workbench.action.terminal.focusPrevious",
    "when": "terminalFocus"
  },
  {
    "key": "ctrl+c",
    "command": "workbench.action.terminal.copySelection",
    "when": "terminalFocus && terminalTextSelected"
  },


]







  {
    "key": "alt+shift+e",
    "command": "editor.foldRecursively",
    "when": "editorTextFocus && !editorHasSelection"
  },
  {
    "key": "alt+shift+d",
    "command": "editor.unfoldRecursively",
    "when": "editorTextFocus && !editorHasSelection"
  },
  {
  "key": "alt+shift+e",
  "command": "editor.createFoldingRangeFromSelection",
  "when": "editorTextFocus && editorHasSelection"
  },
  {
    "key": "alt+shift+d",
    "command": "editor.removeManualFoldingRanges",
    "when": "editorTextFocus && editorHasSelection"
  },










  - VS Code will complain if the same key is listed more than once; remove or redefine any duplicates (e.g.,
    decide whether Alt+K is navigation or commenting).



### settings.json

// Keep current file highlighted in the explorer
"explorer.autoReveal": true in settings.json

// Enable details when hovering over fns and objs
"editor.hover.enabled": true,
"editor.hover.delay": 200,
"editor.hover.sticky": true,
"editor.foldingStrategy": "auto"

### Extensions:

- "Double Shift": Enables the Shift Shift chord to launch Quick Open.


### Tasks & Save Hooks

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




### Already exist:

F2 for renaming a file, and refactoring where the name is used

ctrl J opens and closes bottom panel (terminal, debug console, etc)

Scope showing: when in an if statement that is in a for loop, which is in an fn, you start to get lost as to where exactly you even are. In what context is this line of code I am looking at?
So it is nice to see the fn signature, for loop start, if start, on the top of the page. So you exactly know what scope you are in.

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





### Reload VScode

Reload VS Code after editing settings.json/keybindings.json to ensure all keybindings stick.











## Explanations


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


