




## Goals


### (already done in regular settings)
- make vim toggle (alt M)
- key repeat (pressed key keeps repeating) (windows vscode already has this)
- caps lock maps to esc

### Actual goals:
- make tab and shift tab work when in visual mode or visual block mode, and on a selection in insert mode
- cmd c to be copy when in visual or visual block mode
- all ctrl, alt, and cmd vim keybindings to be ignored by vim when in insert mode (so all keybindings work correctly)

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


    // Enable vim-surround motions: S in Visual, ys/ds/cs in Normal, etc.
    "vim.surround": true,

    // Give yourself more time for multi-key chords (e.g. g<char>, z<char>).
    // "vim.timeout": true,
    // "vim.timeoutlen": 1000,




    // Let VS Code handle keybindings
    "vim.handleKeys": {
      // ==========================
      // CTRL — letters (A–Z)
      // ==========================
      "<C-a>": false, "<C-b>": false, "<C-c>": false, "<C-d>": false, "<C-e>": false,
      "<C-f>": false, "<C-g>": false, "<C-h>": false, "<C-i>": false, "<C-j>": false,
      "<C-k>": false, "<C-l>": false, "<C-m>": false, "<C-n>": false, "<C-o>": false,
      "<C-p>": false, "<C-q>": false, "<C-r>": false, "<C-s>": false, "<C-t>": false,
      "<C-u>": false, "<C-v>": false, "<C-w>": false, "<C-x>": false, "<C-y>": false, "<C-z>": false,

      // ==========================
      // CTRL — numbers (0–9) + common specials
      // ==========================
      "<C-0>": false, "<C-1>": false, "<C-2>": false, "<C-3>": false, "<C-4>": false,
      "<C-5>": false, "<C-6>": false, "<C-7>": false, "<C-8>": false, "<C-9>": false,
      "<C-Left>": false, "<C-Right>": false, "<C-Up>": false, "<C-Down>": false,
      "<C-Home>": false, "<C-End>": false, "<C-PageUp>": false, "<C-PageDown>": false,
      "<C-Backspace>": false, "<C-Delete>": false, "<C-Insert>": false,
      "<C-Enter>": false, "<C-Tab>": false, "<C-Escape>": false,

      // ==========================
      // ALT / OPTION (and META) — letters (A–Z)
      // Use <A-…> for Alt/Option; <M-…> included for Meta compatibility
      // ==========================
      "<A-a>": false, "<A-b>": false, "<A-c>": false, "<A-d>": false, "<A-e>": false,
      "<A-f>": false, "<A-g>": false, "<A-h>": false, "<A-i>": false, "<A-j>": false,
      "<A-k>": false, "<A-l>": false, "<A-m>": false, "<A-n>": false, "<A-o>": false,
      "<A-p>": false, "<A-q>": false, "<A-r>": false, "<A-s>": false, "<A-t>": false,
      "<A-u>": false, "<A-v>": false, "<A-w>": false, "<A-x>": false, "<A-y>": false, "<A-z>": false,

      "<M-a>": false, "<M-b>": false, "<M-c>": false, "<M-d>": false, "<M-e>": false,
      "<M-f>": false, "<M-g>": false, "<M-h>": false, "<M-i>": false, "<M-j>": false,
      "<M-k>": false, "<M-l>": false, "<M-m>": false, "<M-n>": false, "<M-o>": false,
      "<M-p>": false, "<M-q>": false, "<M-r>": false, "<M-s>": false, "<M-t>": false,
      "<M-u>": false, "<M-v>": false, "<M-w>": false, "<M-x>": false, "<M-y>": false, "<M-z>": false,

      // ==========================
      // ALT / OPTION (and META) — numbers + navigation/specials
      // ==========================
      "<A-0>": false, "<A-1>": false, "<A-2>": false, "<A-3>": false, "<A-4>": false,
      "<A-5>": false, "<A-6>": false, "<A-7>": false, "<A-8>": false, "<A-9>": false,
      "<A-Left>": false, "<A-Right>": false, "<A-Up>": false, "<A-Down>": false,
      "<A-Home>": false, "<A-End>": false, "<A-PageUp>": false, "<A-PageDown>": false,
      "<A-Backspace>": false, "<A-Delete>": false, "<A-Insert>": false,
      "<A-Enter>": false, "<A-Tab>": false, "<A-Escape>": false,

      "<M-0>": false, "<M-1>": false, "<M-2>": false, "<M-3>": false, "<M-4>": false,
      "<M-5>": false, "<M-6>": false, "<M-7>": false, "<M-8>": false, "<M-9>": false,
      "<M-Left>": false, "<M-Right>": false, "<M-Up>": false, "<M-Down>": false,
      "<M-Home>": false, "<M-End>": false, "<M-PageUp>": false, "<M-PageDown>": false,
      "<M-Backspace>": false, "<M-Delete>": false, "<M-Insert>": false,
      "<M-Enter>": false, "<M-Tab>": false, "<M-Escape>": false,

      // ==========================
      // SHIFT — special/navigation keys (Shifted letters are usually just letters; pass specials explicitly)
      // (This includes Shift+Tab so VS Code outdent works.)
      // ==========================
      "<S-Tab>": false, "<S-Enter>": false, "<S-Backspace>": false, "<S-Delete>": false, "<S-Insert>": false,
      "<S-Left>": false, "<S-Right>": false, "<S-Up>": false, "<S-Down>": false,
      "<S-Home>": false, "<S-End>": false, "<S-PageUp>": false, "<S-PageDown>": false,
      "<S-Escape>": false, "<S-SPACE>": false,

      // ==========================
      // Function keys — pass through all F1–F24
      // ==========================
      "<F1>": false, "<F2>": false, "<F3>": false, "<F4>": false, "<F5>": false, "<F6>": false,
      "<F7>": false, "<F8>": false, "<F9>": false, "<F10>": false, "<F11>": false, "<F12>": false,
      "<F13>": false, "<F14>": false, "<F15>": false, "<F16>": false, "<F17>": false, "<F18>": false,
      "<F19>": false, "<F20>": false, "<F21>": false, "<F22>": false, "<F23>": false, "<F24>": false
    },
}
```







### keybindings.json


Good news: in **Insert mode**, VS Code keybindings naturally take precedence for most Ctrl/Alt/Cmd shortcuts.
The settings.json above passes Ctrl and Alt keys to VS Code via `handleKeys`.
On macOS, Cmd shortcuts (copy, cut, redo) are handled in keybindings.json below.

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

  // --- Cmd+C = Copy in Visual modes ---
  {
    "key": "cmd+c",
    "command": "editor.action.clipboardCopyAction",
    "when": "editorTextFocus && (vim.mode == 'Visual' || vim.mode == 'VisualLine' || vim.mode == 'VisualBlock')"
  },

  // --- CUT (Cmd+X) ---
  // Cut in INSERT when there is a selection
  {
    "key": "cmd+x",
    "command": "editor.action.clipboardCutAction",
    "when": "editorTextFocus && vim.mode == 'Insert' && editorHasSelection"
  },
  // Cut in VISUAL/LINE/BLOCK (there's always a selection)
  {
    "key": "cmd+x",
    "command": "editor.action.clipboardCutAction",
    "when": "editorTextFocus && (vim.mode == 'Visual' || vim.mode == 'VisualLine' || vim.mode == 'VisualBlock')"
  },

  // --- REDO (Cmd+Shift+Z) ---
  // Make Cmd+Shift+Z redo across modes (standard macOS redo)
  {
    "key": "cmd+shift+z",
    "command": "redo",
    "when": "editorTextFocus && (vim.mode == 'Insert' || vim.mode == 'Normal' || vim.mode == 'Visual' || vim.mode == 'VisualLine' || vim.mode == 'VisualBlock')"
  }
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