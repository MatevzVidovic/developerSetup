# Claude Code Complete Setup Guide

This repository contains a comprehensive setup for Claude Code with MCP servers.

## Features Implemented


### 4. MCP Servers with Docker
Located in `claude_code_infra/`:
- **Zen MCP** - Consult other AI models (including free Gemini)
- **GitHub MCP** - Project planning and issue management
- **Google Keep MCP** - Note-taking and task management
- **Atlassian MCP** - Jira ticket management
- **WebSearch** - Enhanced web search capability
- All servers run in Docker containers for isolation

### 5. Web Search Integration
- Configured in `.mcp.json` as `websearch` server
- Native Claude Code already has WebSearch tool
- Additional MCP server for enhanced search capabilities

## Setup Instructions

### 1. Initial Setup

#### Install Task (optional, for Taskfile)
```bash
# Windows (using Scoop)
scoop install task

# macOS
brew install go-task/tap/go-task

# Linux
sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d
```

#### Configure Auto-Allowed Commands
The `.claude/settings.local.json` already includes common commands. Add more as needed.

### 2. Using Project Templates

When starting a new project:
```bash
# Copy template files to your project
cp -r claude_project_template/* /path/to/your/project/
cp -r claude_project_template/.claude /path/to/your/project/

# In your project, use the task commands
cd /path/to/your/project
task help  # or: make help
```

### 3. Setting Up MCP Servers

#### Step 1: Configure Environment Variables
```bash
cd claude_code_infra/mcp-servers

# For each server, copy .env.example to .env and add your API keys
cp zen/.env.example zen/.env
cp github/.env.example github/.env
cp google-keep/.env.example google-keep/.env
cp atlassian/.env.example atlassian/.env

# Edit each .env file with your credentials
```

#### Step 2: Build and Start Docker Containers
```bash
cd claude_code_infra

# Build all MCP server images
docker-compose build

# Start all services
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f
```

#### Step 3: Enable MCP Servers in Claude Code
Add to your `.claude/settings.local.json`:
```json
{
  "enableAllProjectMcpServers": true,
  "enabledMcpjsonServers": ["zen", "github", "google-keep", "atlassian", "websearch"]
}
```


### 4. Using the Development Guidelines
Claude Code will automatically read and follow guidelines when you:
1. Copy template files to your project
2. Ask Claude to "follow the project guidelines"
3. Reference specific files like "check DEVELOPMENT_GUIDELINES.md"

## Free Gemini Integration for Model Consultation

The Zen MCP server is configured to use Google's Gemini API by default:
1. Get a free API key from [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Add it to `claude_code_infra/mcp-servers/zen/.env`
3. Claude can now consult Gemini for free through the Zen server

## Custom MCP Server Development

To create a custom MCP server:

1. Create a new directory in `claude_code_infra/mcp-servers/`
2. Add these files:
   ```
   my-server/
   ├── Dockerfile
   ├── package.json
   ├── tsconfig.json
   ├── .env.example
   └── src/
       └── index.ts
   ```

3. Add to `docker-compose.yml`:
   ```yaml
   my-server-mcp:
     build: ./mcp-servers/my-server
     container_name: claude-my-server-mcp
     env_file: ./mcp-servers/my-server/.env
     ports:
       - "3006:3000"
     restart: unless-stopped
   ```

4. Add to `.mcp.json`:
   ```json
   "my-server": {
     "command": "docker",
     "args": ["run", "--rm", "-i", "--network", "host", "claude-my-server-mcp"],
     "description": "My custom MCP server"
   }
   ```

## Troubleshooting

### MCP Servers Not Connecting
1. Check Docker is running: `docker ps`
2. View logs: `docker-compose logs [service-name]`
3. Verify ports aren't in use: `netstat -an | grep 300[1-5]`
4. Ensure `.env` files have correct API keys

### Permission Errors
1. Check `.claude/settings.local.json` for command patterns
2. Add missing commands to the `allow` list
3. Use wildcards for command variations: `"Bash(npm:*)"``

### Task/Make Commands Not Found
1. Ensure you're in a directory with Taskfile.yml or Makefile
2. Install Task runner if using Taskfile
3. Use `make` for Makefile, `task` for Taskfile

## VS Code Extension Integration

For VS Code users, the Claude extension works alongside this setup:
1. Install "Claude for VS Code" extension
2. Settings sync with this configuration
3. Use Cmd+L (Mac) or Ctrl+L (Windows/Linux) to chat with Claude

## Next Steps

1. **Copy template to your projects**: Use the templates as a starting point
2. **Configure MCP servers**: Add API keys and start Docker containers
3. **Customize guidelines**: Adapt DEVELOPMENT_GUIDELINES.md to your needs
4. **Create project-specific tasks**: Extend Taskfile/Makefile for your workflow

## Support and Feedback

For issues or suggestions:
- Report at: https://github.com/anthropics/claude-code/issues
- Check Claude Code docs for updates
- Modify this setup to fit your specific needs