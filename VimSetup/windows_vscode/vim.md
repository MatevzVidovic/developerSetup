




## Goals


### (already done in regular settings)
- make vim toggle (alt M)
- key repeat (pressed key keeps repeating) (windows vscode already has this)
- caps lock maps to esc

### Actual goals:
- make tab and shift tab work when in visual mode or visual block mode, and on a selection in insert mode
- ctrl c to be copy when in visual or visual block mode
- all ctrl and alt vim keybindings to be ignored by vim when in insert mode (so all keybindings work correctly)

- yank to not just going to vim register but also to clipboard
- add some char before and after a block

### Left for later:
- set timeout limit for writing the command in full to a larger interval
- add more g<char> and /<char> commands in vim that do more complex operations that you often do




## Solutions


### settings.json

```json
{
    "vim.vimrc.enable": true,
    "vim.vimrc.path": "~/.vscodevimrc",

    // Allow moving to next/previous line when moving left/right at beginning/end of line.
    "vim.whichwrap": "<,>", // sadly only works in Normal/Visual mode, not Insert mode

    // Make yanks go to your OS clipboard too (yy, y, d, etc.).
    // "vim.useSystemClipboard": true,

    "vim.normalModeKeyBindingsNonRecursive": [
        { "before": ["y"], "after": ["\"", "+", "y"] },
        { "before": ["Y"], "after": ["\"", "+", "Y"] },
        // { "before": ["x"], "after": ["\"", "+", "x"] },  // optional — cut single chars

        { "before": ["p"], "after": ["\"", "+", "p"] },
        { "before": ["P"], "after": ["\"", "+", "P"] }
    ],
    "vim.visualModeKeyBindingsNonRecursive": [
        { "before": ["y"], "after": ["\"", "+", "y"] },
        { "before": ["x"], "after": ["\"", "+", "x"] }
    ],


    // Enable vim-surround motions: S in Visual, ys/ds/cs in Normal, etc.
    "vim.surround": true,

    // Give yourself more time for multi-key chords (e.g. g<char>, z<char>).
    // "vim.timeout": true,
    // "vim.timeoutlen": 1000,

    // Let VS Code handle Ctrl+C so we can bind it to Copy in Visual modes below.
    // (If you later want other Ctrl/Alt combos to be handled by VS Code, add them here.)
    "vim.handleKeys": {
        "<C-c>": false,
        "<C-y>": false,
        "<C-x>": false,
        "<C-a>": false,
        "<C-w>": false,
        "<C-j>": false,
        "<C-f>": false,
    },
}
```







### keybindings.json


Good news: in **Insert mode**, VS Code keybindings naturally take precedence for most Ctrl/Alt shortcuts. 
The main common offender is `<C-c>`, which we already handed back to VS Code
And, actually, C-y and C-x are also offending.

```json
[
  // ---------- VIM KEYBINDINGS ADJUSTMENTS ----------

  // --- TAB / SHIFT+TAB in VISUAL & VISUAL BLOCK ---
  // Indent selection with Tab
  {
    "key": "tab",
    "command": "editor.action.indentLines",
    "when": "editorTextFocus && (vim.mode == 'Visual' || vim.mode == 'VisualLine' || vim.mode == 'VisualBlock')"
  },
  // Outdent selection with Shift+Tab
  {
    "key": "shift+tab",
    "command": "editor.action.outdentLines",
    "when": "editorTextFocus && (vim.mode == 'Visual' || vim.mode == 'VisualLine' || vim.mode == 'VisualBlock')"
  },

  // --- TAB / SHIFT+TAB on a selection while in INSERT ---
  // (If there’s a selection during Insert, make Tab/Shift+Tab indent/outdent.)
  {
    "key": "tab",
    "command": "editor.action.indentLines",
    "when": "editorTextFocus && vim.mode == 'Insert' && editorHasSelection"
  },
  {
    "key": "shift+tab",
    "command": "editor.action.outdentLines",
    "when": "editorTextFocus && vim.mode == 'Insert' && editorHasSelection"
  },

  // --- Ctrl+C = Copy in Visual modes ---
  {
    "key": "ctrl+c",
    "command": "editor.action.clipboardCopyAction",
    "when": "editorTextFocus && (vim.mode == 'Visual' || vim.mode == 'VisualLine' || vim.mode == 'VisualBlock')"
  },

  // --- CUT (Ctrl+X) ---
  // Cut in INSERT when there is a selection
  {
    "key": "ctrl+x",
    "command": "editor.action.clipboardCutAction",
    "when": "editorTextFocus && vim.mode == 'Insert' && editorHasSelection"
  },
  // Cut in VISUAL/LINE/BLOCK (there's always a selection)
  {
    "key": "ctrl+x",
    "command": "editor.action.clipboardCutAction",
    "when": "editorTextFocus && (vim.mode == 'Visual' || vim.mode == 'VisualLine' || vim.mode == 'VisualBlock')"
  },

  // --- REDO (Ctrl+Y) ---
  // Make Ctrl+Y redo across modes
  {
    "key": "ctrl+y",
    "command": "redo",
    "when": "editorTextFocus && (vim.mode == 'Insert' || vim.mode == 'Normal' || vim.mode == 'Visual' || vim.mode == 'VisualLine' || vim.mode == 'VisualBlock')"
  },

  // (Optional) also map Ctrl+Shift+Z -> Redo (handy / mac parity)
  // , { "key": "ctrl+shift+z", "command": "redo", "when": "editorTextFocus" }
]

```


### .vimrc use

#### .vscodevimrc file content

Not all .vimrc commands are supported — only a subset related to key remaps, set options, and some let variables.

```sh

" ===============================
"   VSCodeVim Custom .vimrc
" ===============================


" --- Vim Surround replacements ---
" Quickly wrap visual selections with quotes/brackets/etc.
xnoremap gs" c"<C-r>""<Esc>
xnoremap gs' c'<C-r>"'<Esc>
xnoremap gs` c`<C-r>"`<Esc>
xnoremap gs( c(<C-r>")<Esc>
xnoremap gs[ c[<C-r>"]<Esc>
xnoremap gs{ c{<C-r>"}<Esc>

" --- Preserve yank buffer ---
" Always paste from register 0 (pure yanks, not deletes/changes)
nnoremap p "0p
nnoremap P "0P
xnoremap p "0p
xnoremap P "0P





" --- ChatGPT suggestions: ---


" --- General UI ---
set number
set relativenumber
set clipboard=unnamedplus      " sync with system clipboard
set nowrap
set incsearch
set ignorecase
set smartcase

" --- Quick cut command ---
" Select text → press gx → yank & delete
xnoremap gx ygvx

" --- Quality-of-life shortcuts ---
" Use 'jj' to exit insert mode
inoremap jj <Esc>

" Semicolon = command mode (like ':' shortcut)
nnoremap ; :

" Don't move cursor after yanking (handy in VS Code)
nnoremap y myy`y
xnoremap y myy`y

```