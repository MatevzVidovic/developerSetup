# VSCode GoLand-like Setup

This configuration provides VSCode with GoLand-like features and keybindings, optimized for macOS (cmd) with ctrl and alt alternatives.

## Quick Setup

1. **Copy Configuration Files**:
   - Copy `settings.json` to: `~/Library/Application Support/Code/User/settings.json`
   - Copy `keybindings.json` to: `~/Library/Application Support/Code/User/keybindings.json`
   - Copy `launch.json` and `tasks.json` to your project's `.vscode/` folder

2. **Install Recommended Extensions**:
   ```bash
   # Install from extensions.json
   code --install-extension eamodio.gitlens
   code --install-extension mhutchie.git-graph
   code --install-extension hbenl.vscode-test-explorer
   code --install-extension ryanluker.vscode-coverage-gutters
   code --install-extension usernamehw.errorlens
   # ... (see full list in extensions.json)
   ```

3. **Restart VSCode** to apply all settings.

## Key Features

### Search & Replace
- `cmd+f` / `ctrl+f` / `alt+f`: Find
- `↑/↓` arrows: Navigate matches when find widget is open
- `esc`: Close find widget
- `cmd+r` / `ctrl+r` / `alt+r`: Find & Replace
- `tab`: Toggle replace mode
- `cmd+shift+f` / `ctrl+shift+f` / `alt+shift+f`: Find in files
- `shift+shift`: Quick open file

### Navigation
- `cmd+[` / `ctrl+[` / `alt+[`: Go back to previous location
- `cmd+]` / `ctrl+]` / `alt+]`: Go forward to next location
- `cmd+b` / `ctrl+b` / `alt+b`: Go to definition/usage
- `cmd+shift+[` / `ctrl+shift+[` / `alt+shift+[`: Previous tab
- `cmd+shift+]` / `ctrl+shift+]` / `alt+shift+]`: Next tab

### Code Manipulation
- `cmd+shift+p` / `ctrl+shift+p` / `alt+shift+p`: Auto-fix linter issues
- `cmd+shift+c` / `ctrl+shift+c` / `alt+shift+c`: Copy file path
- `cmd+shift+-` / `ctrl+shift+-` / `alt+shift+-`: Collapse all code
- `cmd+shift+=` / `ctrl+shift+=` / `alt+shift+=`: Expand all code
- `cmd+-` / `ctrl+-` / `alt+-`: Collapse current section
- `cmd+=` / `ctrl+=` / `alt+=`: Expand current section

### Comments
- `cmd+/` / `ctrl+/` / `alt+/`: Toggle line comments
- `cmd+shift+/` / `ctrl+shift+/` / `alt+shift+/`: Toggle block comments

### Refactoring
- `alt+m`: Rename variable/function
- Right-click menu also provides refactoring options

### Tab Management
- `cmd+1-9` / `ctrl+1-9` / `alt+1-9`: Go to tab by number
- `cmd+left/right` / `ctrl+left/right` / `alt+left/right`: Navigate tabs
- Double-click tab: Reveal in file explorer

### File Tree Navigation
- `cmd+0` / `ctrl+0` / `alt+0`: Focus file explorer
- `F2`: Rename file/variable
- `→`: Expand directory
- `←`: Collapse directory
- `Enter`: Open file
- `ctrl+shift+n`: New folder
- `alt+n`: New file

### Testing & Debugging
- `F12`: Re-run last task/test
- Click play button next to test functions to run individual tests
- Built-in coverage support
- Debugging configurations for Go, Python, Node.js, TypeScript

### Git Integration
- GitLens provides heatmap showing recent changes
- Git Graph for visual commit history
- Built-in diff viewer
- Cherry-pick support through Git Graph extension

## Advanced Features

### Code Visualization
- **Shadowing Detection**: Variables in inner scopes are highlighted
- **Scope Breadcrumbs**: See current function/class context at top
- **Hover Definitions**: Automatic definition peek on hover
- **Error Lens**: Inline error messages
- **Bracket Pair Colorization**: Matching brackets have same color

### Editor Behavior
- **Extended Undo**: 50,000 undo steps (vs default ~20)
- **Save Behavior**: Auto-fix on save, but no auto-formatting that expands code
- **Code Folding**: Files open with imports/functions collapsed
- **Auto-save**: Files save automatically after 1 second

### Language-Specific Settings
- **Go**: Formats on save, organizes imports
- **Python**: Black formatter, import sorting
- **TypeScript/JavaScript**: ESLint auto-fix on save
- **All Languages**: Intelligent hover, auto-completion

## Extension Highlights

### Essential Extensions
- **GitLens**: Advanced Git integration with heatmaps and blame
- **Git Graph**: Visual commit history and cherry-picking
- **Test Explorer**: Unified testing interface
- **Coverage Gutters**: Line-by-line test coverage
- **Error Lens**: Inline error display

### Productivity Extensions
- **Todo Tree**: Track TODO comments
- **Better Comments**: Color-coded comment types
- **Bookmarks**: Navigate between marked lines
- **Path Intellisense**: Auto-complete file paths

### Visual Extensions
- **VSCode Icons**: Better file/folder icons
- **Indent Rainbow**: Color-coded indentation levels
- **Rainbow CSV**: Color columns in CSV files

## Custom Tasks

Available through `cmd+shift+p` → "Tasks: Run Task":
- **Go**: Build, Test, Test with Coverage, Format
- **Python**: Test, Test with Coverage, Format with Black
- **Node.js**: Test, Test with Coverage, ESLint Fix, Prettier Format

## Debugging Configurations

Pre-configured debug setups for:
- Go files and tests
- Python files and tests
- Node.js and TypeScript files
- Jest tests with coverage

## Troubleshooting

### Shift+Shift Not Working
The double-shift shortcut might conflict with system shortcuts. Alternative: `cmd+p`

### Extensions Not Working
1. Restart VSCode after installing extensions
2. Check extension requirements (some need language servers)
3. Verify workspace trust settings

### Keybindings Conflicts
1. Open `cmd+k cmd+s` to see keyboard shortcuts
2. Look for conflicts (red warning icons)
3. Modify keybindings.json to resolve conflicts

### Performance Issues
1. Exclude large directories in settings.json search.exclude
2. Disable unused extensions
3. Increase file watcher limits if needed

## Platform Notes

- Primary shortcuts use `cmd` for macOS
- All shortcuts have `ctrl` and `alt` alternatives
- File paths assume macOS structure
- Terminal defaults to zsh (macOS default)

## Getting Help

For VSCode-specific issues:
- `cmd+shift+p` → "Help: Welcome"
- Visit VSCode documentation

For this configuration:
- Check individual extension documentation
- Modify settings.json for custom preferences
- Adjust keybindings.json for personal workflow