




## Setup

### Keybindings

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

    { "key": "alt+e",           "command": "editor.fold" },
    { "key": "alt+r",           "command": "editor.unfold" },
    { "key": "alt+shift+e",     "command": "editor.foldAll" },
    { "key": "alt+shift+r",     "command": "editor.unfoldAll" },

    { "key": "alt+k",           "command": "editor.action.commentLine", "when": "editorTextFocus" },
    { "key": "alt+shift+k",     "command": "editor.action.removeCommentLine" },

    { "key": "alt+g",           "command": "workbench.files.action.focusFilesExplorer" },
    { "key": "ctrl+shift+n",    "command": "explorer.newFolder" },
    { "key": "alt+shift+n",     "command": "explorer.newFile" },

    { "key": "alt+shift+p",     "command": "workbench.action.tasks.runTask" }, // gives you choice of which task in tasks.json to run

    { "key": "alt+shift+.",     "command": "workbench.files.action.showActiveFileInExplorer" }  // to quickly reveal current file in explorer 
  ]

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


