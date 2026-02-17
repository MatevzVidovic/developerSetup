




## Setup

### Keybindings.json

  - Open File → Preferences → Keyboard Shortcuts (JSON) and drop in the mappings below (adjust any existing
    duplicates as needed):

[
  // search
  { "key": "alt+f",           "command": "editor.actions.find" },
  { "key": "alt+r",           "command": "editor.action.startFindReplaceAction" },
  // awesome feature to remember - in the find field, there is a button to toggle "Find in selection":
  // you do alt f, make a selection, then click that button, 
  // and now that selection of lines permanently stays the find selection until you click the button again.
  //  You can even replace things only in that selection.
  { "key": "shift shift",     "command": "workbench.action.quickOpen" },
  { "key": "alt+shift+f",     "command": "workbench.action.findInFiles" }, // toggle search details (3 dots), then book icon to search only in open tabs
  // to search in a specific folder, you can eaiter write out the include path in the search bar, 
  // or right click the folder in explorer and choose "Find in Folder"

  // implementations and definitions navigation
  { "key": "alt+.",           "command": "editor.action.referenceSearch.trigger" }, // find all refs to var/function/class under cursor
  { "key": "alt+h",           "command": "workbench.action.navigateBack" },
  { "key": "alt+l",           "command": "workbench.action.navigateForward" },
  
  // tab navigation and manaagement
  { "key": "alt+w",           "command": "workbench.action.closeActiveEditor" }, // also closes groups (side panels)
  { "key": "alt+left",        "command": "workbench.action.previousEditor" },
  { "key": "alt+right",       "command": "workbench.action.nextEditor" }, // goes over group boundaries too
  { "key": "ctrl+shift+left", "command": "workbench.action.moveEditorLeftInGroup","when": "editorTextFocus" }, // moves current tab left within its group
  { "key": "ctrl+shift+right","command": "workbench.action.moveEditorRightInGroup","when": "editorTextFocus" },
  { "key": "alt+cmd+right", "command": "workbench.action.moveEditorToNextGroup", "when": "editorIsOpen" }, // moves current tab to next group (side-panel). Creates group if it didn't exist.
  { "key": "alt+cmd+left",  "command": "workbench.action.moveEditorToPreviousGroup", "when": "editorIsOpen" },
  { "key": "alt+9",           "command": "workbench.action.lastEditorInGroup" },
  // { "key": "alt+1",           "command": "workbench.action.openEditorAtIndex1" }, // for some reason, this tries to move to the group with that ix, not the tab
  // { "key": "alt+2",           "command": "workbench.action.openEditorAtIndex2" }, // so alt 2 just created a new group (side panel) and so on.
  // { "key": "alt+3",           "command": "workbench.action.openEditorAtIndex3" }, // But,
  // { "key": "alt+4",           "command": "workbench.action.openEditorAtIndex4" }, // This is kind of nice too.
  // { "key": "alt+5",           "command": "workbench.action.openEditorAtIndex5" }, // Because actually alt + left/right works well,
  // { "key": "alt+6",           "command": "workbench.action.openEditorAtIndex6" }, // and now I can use alt+1..8 for other things I think of on the fly.
  // { "key": "alt+7",           "command": "workbench.action.openEditorAtIndex7" },
  // { "key": "alt+8",           "command": "workbench.action.openEditorAtIndex8" },
  
  // commenting
  { "key": "alt+k",           "command": "editor.action.commentLine",  "when": "editorTextFocus" },
  { "key": "alt+shift+k",     "command": "editor.action.removeCommentLine" },
  
  // file explorer
  { "key": "alt+g",           "command": "workbench.files.action.focusFilesExplorer" },
  // if when condiotion is met, the below keybinding will override the above one.
  // It will close the explorer if it is already open and in focus.
  { "key": "alt+g",    "command": "workbench.action.closeSidebar",    "when": "explorerViewletVisible && activeViewlet == 'workbench.view.explorer'"  }, 
  { "key": "cmd+shift+n",    "command": "explorer.newFolder" },
  { "key": "alt+shift+n",     "command": "explorer.newFile" },
  { "key": "alt+shift+.",     "command": "workbench.files.action.showActiveFileInExplorer" },  // to quickly reveal current file in explorer 

  // miscelaneous
  { "key": "alt+b",     "command": "editor.action.rename" }, // for var name refactoring
  { "key": "alt+p",     "command": "workbench.action.tasks.runTask" }, // gives you choice of which task in tasks.json to run
  { "key": "alt+shift+c",     "command": "workbench.action.files.copyPathOfActiveFile" }, // good for telling CLI LLMs about a file
  { "key": "alt+m",           "command": "toggleVim" }, // if using vim extension, toggle it on/off quickly

  // Folding and unfolding code blocks
  { "key": "alt+d",     "command": "multicommand.fold.eachSelectedLineRecursively",  "when": "editorTextFocus && editorHasSelection" },  // to fold all, just do alt+A, alt+shift+e
  { "key": "alt+shift+d",     "command": "multicommand.unfold.eachSelectedLineRecursively",  "when": "editorTextFocus && editorHasSelection" },
  { "key": "alt+d",     "command": "editor.fold",  "args": { "levels": 2, "direction": "down" },  "when": "editorTextFocus && !editorHasSelection" },
  { "key": "alt+shift+d",     "command": "editor.unfoldRecursively",  "when": "editorTextFocus && !editorHasSelection" },

  // IDE terminal navigation and creation
  { "key": "cmd+t",          "command": "workbench.action.terminal.newWithCwd",  "args": { "cwd": "${workspaceFolder}" }, "when": "terminalFocus" },
  { "key": "cmd+n",          "command": "workbench.action.terminal.newWithCwd",  "args": { "cwd": "${fileDirname}" }, "when": "editorTextFocus"  },
  { "key": "cmd+right",      "command": "workbench.action.terminal.focusNext",  "when": "terminalFocus"  },
  { "key": "cmd+left",       "command": "workbench.action.terminal.focusPrevious",  "when": "terminalFocus"  },
  { "key": "cmd+c",          "command": "workbench.action.terminal.copySelection",  "when": "terminalFocus && terminalTextSelected"  },
]



  - VS Code will complain if the same key is listed more than once; remove or redefine any duplicates (e.g.,
    decide whether Alt+K is navigation or commenting).




### Already exist:

Just press Enter when on file for renaming a file, and refactoring where the name is used

cmd J opens and closes bottom panel (terminal, debug console, etc)

Scope showing: when in an if statement that is in a for loop, which is in an fn, you start to get lost as to where exactly you even are. In what context is this line of code I am looking at?
So it is nice to see the fn signature, for loop start, if start, on the top of the page. So you exactly know what scope you are in.


