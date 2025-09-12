@echo off
REM Watch for Claude Code creating its own settings and override them
REM Usage: watch-settings.bat [target_directory]

set "TARGET_DIR=%~1"
if "%TARGET_DIR%"=="" set "TARGET_DIR=."

set "SETUP_DIR=%~dp0.."

echo Watching %TARGET_DIR%\.claude\ for changes...
echo Press Ctrl+C to stop

:loop
if exist "%TARGET_DIR%\.claude\settings.local.json" (
    fc /b "%SETUP_DIR%\.claude\master-settings.json" "%TARGET_DIR%\.claude\settings.local.json" >nul 2>&1
    if errorlevel 1 (
        echo Settings file changed, restoring master settings...
        copy "%SETUP_DIR%\.claude\master-settings.json" "%TARGET_DIR%\.claude\settings.local.json" >nul
    )
)
timeout /t 5 /nobreak >nul
goto loop