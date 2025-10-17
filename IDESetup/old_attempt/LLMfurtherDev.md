# LLM Further Development Instructions

This document provides comprehensive instructions for future Claude development sessions to improve, extend, and troubleshoot the VSCode GoLand-like configuration.

## Project Context & Goals

### Original Requirements (from wantedFeatures.md)
The user wants VSCode configured to replicate GoLand functionality with:
- macOS-focused keybindings (cmd) with ctrl/alt alternatives
- Advanced search, navigation, and refactoring capabilities
- Testing and debugging integration
- Git workflow enhancements
- Code visualization features (scoping, shadowing detection, etc.)
- File management improvements

### Configuration Files Structure
```
IDESetup/
├── settings.json          # Main VSCode settings
├── keybindings.json      # Custom keybinding definitions
├── extensions.json       # Recommended extensions list
├── launch.json          # Debugging configurations
├── tasks.json           # Build/test task definitions
├── README.md            # User-facing setup guide
├── wantedFeatures.md    # Original requirements
└── LLMfurtherDev.md     # This file
```

## Known Issues & Limitations (As of 2025)

### 1. Shift+Shift Quick Open
**Issue**: The double-shift keybinding may conflict with system shortcuts or extensions.
**Current Implementation**: `{"key": "shift shift", "command": "workbench.action.quickOpen", "when": "!inQuickOpen"}`
**Potential Issues**:
- May not work on all systems
- Extension conflicts (especially IntelliJ keybindings extension)
- Timing sensitivity issues

**Future Improvements**:
```json
// Alternative implementation with timeout
{
  "key": "shift shift",
  "command": "workbench.action.quickOpen",
  "when": "!inQuickOpen && !terminalFocus && !findInputFocussed"
}
```

### 2. Double-Click Tab to Reveal in Explorer
**Issue**: No native VSCode support or reliable extension found.
**Current Workaround**: 
- Added `cmd+shift+r` keybinding for `workbench.files.action.showActiveFileInExplorer`
- Enabled `explorer.autoReveal: true`
- Set `workbench.list.openMode: "doubleClick"`

**Future Development Options**:
1. Create custom extension for this specific functionality
2. Use VSCode API to intercept tab double-click events
3. Monitor for new VSCode features or community extensions

### 3. Advanced Code Folding Behavior
**Current State**: Files open with everything collapsed via settings, but may not work consistently across all file types.
**Potential Improvements**:
- Language-specific folding rules
- Custom folding providers for better control
- Extension to force folding on file open

## Research-Based Improvements Needed

### AI-Powered Features (VSCode 2025)
VSCode 2025 introduced several AI features that should be integrated:

```json
// Add to settings.json
{
  "github.copilot.enable": {
    "*": true,
    "yaml": false,
    "plaintext": false
  },
  "github.copilot.editor.enableAutoCompletions": true,
  "github.copilot.advanced": {
    "listCount": 10,
    "inlineSuggestCount": 3
  }
}
```

### MCP (Model Context Protocol) Integration
**Research Required**: Investigate MCP extensions for external data source access.
**Implementation**: Add MCP-compatible extensions to extensions.json once stable.

### Enhanced Testing Features
**Missing**: Advanced test coverage visualization
**Add to extensions.json**:
```json
"ryanluker.vscode-coverage-gutters",
"ms-vscode.test-adapter-converter",
"hbenl.vscode-test-explorer"
```

## Extension Research & Validation

### Critical Extensions to Verify
Before recommending extensions, future LLM sessions should:

1. **Check Extension Availability**: Verify each extension in extensions.json still exists and is maintained
2. **Version Compatibility**: Ensure extensions work with latest VSCode versions  
3. **Performance Impact**: Research user reviews for performance issues
4. **Alternative Solutions**: Look for newer/better extensions for same functionality

### Extensions Requiring Validation:
- `bradlc.vscode-tailwindcss` (appears multiple times - may be error)
- `formulahendry.*` extensions (check if maintained)
- Theme extensions for 2025 compatibility

## Advanced Configuration Improvements

### 1. Language-Specific Enhancements

**Go Development**:
```json
"[go]": {
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.organizeImports": true,
    "source.fixAll": true
  },
  "editor.insertSpaces": false,
  "editor.detectIndentation": false,
  "editor.tabSize": 4,
  "gopls": {
    "build.buildFlags": ["-tags=integration"],
    "ui.diagnostic.analyses": {
      "shadow": true,
      "unusedparams": true
    }
  }
}
```

**TypeScript/JavaScript**:
```json
"typescript.preferences.importModuleSpecifier": "relative",
"typescript.suggest.autoImports": true,
"typescript.updateImportsOnFileMove.enabled": "always",
"javascript.preferences.importModuleSpecifier": "relative"
```

### 2. Advanced Git Integration

**Missing GitLens Configuration**:
```json
"gitlens.advanced.messages": {
  "suppressCommitHasNoPreviousCommitWarning": true,
  "suppressCommitNotFoundWarning": true,
  "suppressFileNotUnderSourceControlWarning": true,
  "suppressGitVersionWarning": true,
  "suppressLineUncommittedWarning": true,
  "suppressNoRepositoryWarning": true
},
"gitlens.blame.format": "${message|50?} ${agoOrDate|14-}",
"gitlens.blame.heatmap.enabled": true,
"gitlens.blame.avatars": true,
"gitlens.codeLens.authors.enabled": true,
"gitlens.codeLens.recentChange.enabled": true
```

### 3. Testing & Debugging Enhancements

**Add to settings.json**:
```json
"testing.automaticallyOpenPeekView": "failureInVisibleDocument",
"testing.followRunningTest": true,
"testing.openTesting": "openOnTestStart",
"debug.console.fontSize": 12,
"debug.console.fontFamily": "Monaco, 'Courier New', monospace",
"debug.focusWindowOnBreak": true,
"debug.showBreakpointsInOverviewRuler": true
```

## Performance Optimization Research

### File Watching & Indexing
Current exclusions may be insufficient. Research and add:
```json
"files.watcherExclude": {
  "**/.git/**": true,
  "**/node_modules/**": true,
  "**/dist/**": true,
  "**/build/**": true,
  "**/.vscode/**": true,
  "**/coverage/**": true,
  "**/.nyc_output/**": true,
  "**/tmp/**": true,
  "**/temp/**": true
}
```

### Search Performance
```json
"search.exclude": {
  "**/node_modules": true,
  "**/dist": true,
  "**/build": true,
  "**/.git": true,
  "**/coverage": true,
  "**/.nyc_output": true,
  "**/logs": true,
  "**/*.log": true
}
```

## Troubleshooting Guide for Future Development

### Common Issues & Solutions

1. **Keybinding Conflicts**:
   - Use `cmd+k cmd+s` to open keyboard shortcuts
   - Look for red warning icons indicating conflicts
   - Check "Source" column to identify extension conflicts
   - Use "Developer: Toggle Keyboard Shortcuts Troubleshooting"

2. **Extension Issues**:
   - Disable extensions one by one to isolate problems
   - Check extension logs in Developer Tools
   - Verify extension requirements are met

3. **Performance Issues**:
   - Monitor CPU/memory usage with Activity Monitor
   - Check if file watchers are overwhelming system
   - Temporarily disable extensions to identify culprits

### Testing New Configuration

**Before releasing updates**:
1. Create backup of working configuration
2. Test with fresh VSCode installation
3. Verify each major feature works:
   - Search & replace workflows
   - Navigation shortcuts
   - Git operations
   - Testing/debugging
   - File management

## Research Tasks for Future Sessions

### Priority 1: Critical Functionality
- [ ] Verify shift+shift implementation across different systems
- [ ] Find solution for double-click tab reveal (extension or workaround)
- [ ] Test code folding behavior with various file types
- [ ] Validate all extensions are still maintained and compatible

### Priority 2: Feature Enhancements  
- [ ] Research new VSCode 2025 AI features integration
- [ ] Investigate MCP protocol extensions
- [ ] Find better shadowing detection solutions
- [ ] Research scope visualization improvements
- [ ] Look into advanced test coverage extensions

### Priority 3: Performance & Polish
- [ ] Benchmark configuration performance impact
- [ ] Optimize file watching patterns
- [ ] Research theme and UI improvements
- [ ] Investigate custom extension development needs

## Development Methodology

### When Making Changes
1. **Always Read Current Files First**: Use Read tool on relevant config files
2. **Research Before Modifying**: Use WebSearch to verify current best practices
3. **Incremental Changes**: Make small, testable modifications
4. **Document Reasoning**: Update this file with rationale for changes
5. **Version Control**: Consider git commits for major changes

### Research Strategy
- Search for "VSCode [feature] 2025" to get latest information
- Check VSCode official documentation for new features
- Look for community discussions on Reddit, Stack Overflow
- Monitor VSCode release notes and changelogs
- Verify extension marketplace status and reviews

### Testing Approach
```bash
# Commands to validate configuration
code --list-extensions
code --version
code --help
```

## Extension Development Opportunities

If native VSCode doesn't support required features, consider developing:

1. **Tab Double-Click Extension**: Intercept tab double-click events
2. **Advanced Folding Extension**: More granular control over code folding
3. **GoLand Workflow Extension**: Bundle common GoLand features
4. **Enhanced File Explorer**: Better reveal/navigation features

## Future VSCode Feature Monitoring

### Watch for Official Support:
- Native double-click tab functionality
- Better shift+shift key detection
- Advanced code folding APIs
- Enhanced debugging features
- Improved Git workflow tools

### API Changes to Monitor:
- Keybinding API improvements
- Tab management API enhancements
- File explorer extensibility
- Testing framework integrations

---

## Notes for Future LLM Sessions

- **Always reference this file** when working on VSCode configuration updates
- **Update this file** when discovering new issues or improvements
- **Research first, implement second** - VSCode features change frequently
- **Consider user's workflow** - prioritize features that match GoLand usage patterns
- **Test incrementally** - don't break working functionality while adding features
- **Document all changes** in both this file and README.md

Remember: The goal is to make VSCode feel like GoLand for this specific user's workflow. Every change should serve that primary objective.