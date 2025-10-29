# Claude Code Project Instructions

## Project Context Files

When working in this project, Claude Code should regularly consult these files:

1. **DEVELOPMENT_GUIDELINES.md** - Core principles and coding standards
2. **LINTER_SETUP.md** - Linting and formatting configuration
3. **Taskfile.yml** or **Makefile** - Available automation commands

## Working Principles

### Before Starting Any Task
1. Read relevant .md files in the project root
2. Check for existing patterns in the codebase
3. Review test structure and coverage requirements
4. Verify linter configuration

### During Development
1. **Modularity First**: Create self-contained, reusable components
2. **Functional Approach**: Prefer pure functions and immutability
3. **Test as You Go**: Write tests alongside implementation
4. **Lint Frequently**: Run linters before committing

### Code Organization
```
src/
├── modules/        # Self-contained, reusable modules
├── utils/          # Pure utility functions
├── types/          # Type definitions (TypeScript)
├── config/         # Configuration files
└── index.js        # Main entry point

tests/
├── unit/           # Unit tests mirroring src/ structure
├── integration/    # Integration tests
└── fixtures/       # Test data and mocks
```

### Git Workflow Commands
Use these Taskfile/Makefile commands:
- `task lint` or `make lint` - Run all linters
- `task test` or `make test` - Run all tests
- `task build` or `make build` - Build the project
- `task git:diff` or `make git-diff` - Show uncommitted changes
- `task git:log` or `make git-log` - Show recent commits
- `task git:diff-range COMMITS=5` - Show diff for last N commits

### Module Creation Checklist
When creating a new module:
- [ ] Create module file in `src/modules/`
- [ ] Export clear public interface
- [ ] Write comprehensive unit tests
- [ ] Add integration tests if needed
- [ ] Document public API
- [ ] Ensure no external dependencies where possible
- [ ] Run linters and fix any issues

### Testing Requirements
- Unit test coverage: minimum 80%
- All public functions must have tests
- Test both success and failure paths
- Include edge cases and boundary conditions
- Performance tests for critical paths

### State Management Guidelines
1. **Avoid Global State**: Use dependency injection
2. **Immutable Updates**: Never mutate, always return new objects
3. **Single Source of Truth**: Centralize state when necessary
4. **Pure Reducers**: State transformations should be pure functions

### Performance Optimization
1. **Measure First**: Use profiling tools before optimizing
2. **Algorithm Complexity**: Focus on Big O improvements
3. **Lazy Loading**: Load resources only when needed
4. **Memoization**: Cache expensive computations
5. **Document Trade-offs**: Explain any performance vs readability decisions

### Security Practices
1. **Input Validation**: Validate all external inputs
2. **Output Sanitization**: Sanitize data before rendering
3. **Dependency Scanning**: Regular security audits
4. **Secrets Management**: Use environment variables, never commit secrets
5. **Least Privilege**: Minimal permissions for all operations

## Quick Reference Commands

### Development Workflow
```bash
# Start development
task dev            # or: make dev

# Run tests
task test           # or: make test
task test:watch     # or: make test-watch

# Linting and formatting
task lint           # or: make lint
task format         # or: make format

# Build project
task build          # or: make build

# Git operations
task git:status     # or: make git-status
task git:diff       # or: make git-diff
task git:log        # or: make git-log
```

### Debugging Helpers
```bash
# Show project structure
task info           # or: make info

# Check dependencies
task deps:check     # or: make deps-check

# Clean build artifacts
task clean          # or: make clean
```

## Integration with Claude Code Features

### When to Use Task/Make Commands
- Before committing code: `task lint test`
- Reviewing changes: `task git:diff`
- Understanding project state: `task info`
- Cleaning up: `task clean`

### Automatic Actions
Claude Code should automatically:
1. Run linters after making significant changes
2. Run tests after implementing features
3. Check git status before and after work
4. Use task/make commands for repetitive operations

### Project Memory
Important decisions and patterns discovered during development should be documented in:
- `docs/decisions/` - Architecture Decision Records (ADRs)
- `docs/patterns/` - Discovered patterns and solutions
- `.claude/memory.md` - Session-specific learnings