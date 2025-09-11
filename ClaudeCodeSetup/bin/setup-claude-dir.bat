@echo off
REM Setup Claude Code directory with proper permissions
REM Usage: setup-claude-dir.bat [target_directory]

set "TARGET_DIR=%~1"
if "%TARGET_DIR%"=="" set "TARGET_DIR=."

set "SETUP_DIR=%~dp0.."

echo Setting up Claude Code configuration in: %TARGET_DIR%

REM Create .claude directory if it doesn't exist
if not exist "%TARGET_DIR%\.claude" mkdir "%TARGET_DIR%\.claude"

REM Copy the all-permissions settings
copy "%SETUP_DIR%\.claude\master-settings.json" "%TARGET_DIR%\.claude\settings.local.json"

REM Create a backup if Claude Code creates its own settings
if not exist "%TARGET_DIR%\.claude\settings.local.json.backup" (
    copy "%TARGET_DIR%\.claude\settings.local.json" "%TARGET_DIR%\.claude\settings.local.json.backup"
)

REM Copy MCP configuration
copy "%SETUP_DIR%\.mcp.json" "%TARGET_DIR%\"

echo Claude Code setup complete!
echo If permissions are still requested, run:
echo copy "%TARGET_DIR%\.claude\settings.local.json.backup" "%TARGET_DIR%\.claude\settings.local.json"