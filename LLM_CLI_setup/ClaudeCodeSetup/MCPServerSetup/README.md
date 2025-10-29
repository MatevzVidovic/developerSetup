# MCP Server Setup for Claude Code

A comprehensive Docker-based setup for Model Context Protocol (MCP) servers that enhances Claude Code with additional capabilities.

## 🚀 Quick Start

1. **Run the setup script:**
   ```bash
   ./setup.sh
   ```

2. **Configure API keys** (see [Configuration](#configuration) section)

3. **Copy MCP configuration to Claude Code:**
   ```bash
   cp .mcp.json ~/.claude/
   # or wherever your Claude Code settings are located
   ```

4. **Start Claude Code** - MCP servers will be automatically available!

## 📦 Included MCP Servers

### Core Servers (Docker-based)
- **🧠 Zen MCP** (Port 3001) - Consult other AI models using OpenRouter/Gemini
- **🐙 GitHub MCP** (Port 3003) - GitHub integration for project planning and issues
- **📝 Google Keep MCP** (Port 3004) - Note-taking and task management  
- **🎯 Atlassian MCP** (Port 3005) - Jira ticket creation and management

### Advanced Servers (Docker-based)
- **📚 Context7 MCP** (Port 3006) - Library documentation lookup and framework guidance
- **🎭 Playwright MCP** (Port 3007) - Browser automation and E2E testing
- **🤖 Consult7 MCP** (Port 3008) - Advanced AI consultation with multiple models
- **🧠 Serena MCP** (Port 3009) - Semantic code understanding with project memory
- **⚡ SuperClaude MCP** (Port 3010) - Enhanced Claude workflow management

### Built-in Servers (Node.js-based)
- **🔍 WebSearch MCP** - Enhanced web search capabilities
- **📁 Filesystem MCP** - Advanced filesystem operations

## 🔧 Configuration

### API Keys Required

Create and configure `.env` files for each service that needs them:

#### Zen MCP (`claude_code_infra/mcp-servers/zen/.env`)
```bash
# For OpenRouter (recommended for multiple models)
OPENROUTER_API_KEY=your_openrouter_key
OPENAI_API_KEY=your_openai_key

# For Google Gemini (free tier available)
GEMINI_API_KEY=your_gemini_key

# For direct Anthropic access
ANTHROPIC_API_KEY=your_anthropic_key
```

#### GitHub MCP (`claude_code_infra/mcp-servers/github/.env`)
```bash
# GitHub Personal Access Token with repo and issues permissions
GITHUB_TOKEN=your_github_token
```

#### Google Keep MCP (`claude_code_infra/mcp-servers/google-keep/.env`)
```bash
# Google OAuth2 credentials (requires Google Cloud Console setup)
GOOGLE_CLIENT_ID=your_client_id
GOOGLE_CLIENT_SECRET=your_client_secret
GOOGLE_REFRESH_TOKEN=your_refresh_token
```

#### Atlassian MCP (`claude_code_infra/mcp-servers/atlassian/.env`)
```bash
# Atlassian/Jira configuration
ATLASSIAN_HOST=your_domain.atlassian.net
ATLASSIAN_EMAIL=your_email@domain.com
ATLASSIAN_API_TOKEN=your_api_token
```

#### WebSearch MCP (Global environment)
```bash
# Add to your shell profile (.bashrc, .zshrc, etc.)
export SEARCH_API_KEY=your_search_api_key  # Google Custom Search or SerpAPI
```

### Advanced Server Configuration

Most advanced servers will work with basic configuration, but you can customize:

- **Context7**: Add Upstash Redis for caching (optional)
- **Playwright**: Customize browser settings
- **Consult7/Serena**: Configure AI model preferences

## 🛠️ Manual Commands

### Build and Start Services
```bash
cd claude_code_infra
docker-compose build
docker-compose up -d
```

### Check Service Status
```bash
docker-compose ps
docker-compose logs [service-name]
```

### Stop Services
```bash
docker-compose down
```

### Rebuild Individual Service
```bash
docker-compose build [service-name]
docker-compose up -d [service-name]
```

## 🔍 Troubleshooting

### Common Issues

1. **Docker not running**
   ```bash
   # Start Docker Desktop or Docker daemon
   sudo systemctl start docker  # Linux
   ```

2. **Port conflicts**
   ```bash
   # Check what's using ports 3001-3010
   netstat -tulpn | grep :300[1-9]
   ```

3. **Environment variables not loading**
   ```bash
   # Verify .env files exist and are properly formatted
   ls -la claude_code_infra/mcp-servers/*/.env
   ```

4. **Service won't start**
   ```bash
   # Check logs for specific service
   docker-compose logs zen-mcp
   ```

### WSL-Specific Issues

1. **Docker integration**
   - Ensure Docker Desktop has WSL2 integration enabled
   - Verify Docker commands work from WSL: `docker --version`

2. **File permissions**
   ```bash
   chmod +x setup.sh
   ```

3. **Network connectivity**
   - Use `--network host` in Docker commands (already configured)

## 🎯 Usage Guide

### When to Use Each MCP Server

| Task Type | Recommended MCP Server |
|-----------|----------------------|
| AI model consultation | **Zen MCP** - Access multiple AI models |
| Code documentation lookup | **Context7 MCP** - Official library docs |
| Browser testing/automation | **Playwright MCP** - Real browser interaction |
| Project management | **GitHub MCP** - Issues, PRs, planning |
| Note-taking/tasks | **Google Keep MCP** - Persistent notes |
| Ticket management | **Atlassian MCP** - Jira integration |
| Web research | **WebSearch MCP** - Enhanced search |
| Code analysis | **Serena MCP** - Semantic understanding |
| Workflow enhancement | **SuperClaude MCP** - Advanced features |

### Custom MCP Development

To create your own MCP server:

1. **Create a new directory:**
   ```bash
   mkdir claude_code_infra/mcp-servers/my-custom-mcp
   ```

2. **Add Dockerfile and package.json**

3. **Update docker-compose.yml:**
   ```yaml
   my-custom-mcp:
     build: ./mcp-servers/my-custom-mcp
     container_name: claude-my-custom-mcp
     ports:
       - "3011:3000"
     restart: unless-stopped
   ```

4. **Update .mcp.json:**
   ```json
   "my-custom": {
     "command": "docker",
     "args": ["run", "--rm", "-i", "--network", "host", "claude-my-custom-mcp"],
     "description": "My custom MCP server"
   }
   ```

## 📋 Claude Code Integration

### Automatic Discovery

Claude Code will automatically discover MCP servers when:
1. The `.mcp.json` file is in the correct location
2. The servers are running and accessible
3. The environment variables are properly configured

### Manual Configuration

If automatic discovery doesn't work:

1. **Copy configuration:**
   ```bash
   cp .mcp.json ~/.claude/
   # or to your Claude Code settings directory
   ```

2. **Restart Claude Code**

3. **Verify in Claude Code settings** that MCP servers appear

## 🚦 Service Health Monitoring

Check if all services are healthy:

```bash
# Quick health check
curl -s http://localhost:3001/health 2>/dev/null && echo "Zen MCP: ✅" || echo "Zen MCP: ❌"
curl -s http://localhost:3003/health 2>/dev/null && echo "GitHub MCP: ✅" || echo "GitHub MCP: ❌"
curl -s http://localhost:3004/health 2>/dev/null && echo "Keep MCP: ✅" || echo "Keep MCP: ❌"
curl -s http://localhost:3005/health 2>/dev/null && echo "Atlassian MCP: ✅" || echo "Atlassian MCP: ❌"
```

## 🔐 Security Considerations

1. **API Keys**: Never commit API keys to version control
2. **Network**: Services use `host` network for WSL compatibility
3. **Environment**: Use `.env` files for sensitive configuration
4. **Access**: MCP servers should only be accessible locally

## 📝 License

This setup configuration is provided as-is. Individual MCP servers may have their own licenses - please check their respective repositories.

## 🤝 Contributing

To add new MCP servers or improve the setup:

1. Fork and create a feature branch
2. Add your MCP server configuration
3. Update documentation
4. Test thoroughly
5. Submit a pull request

## 📞 Support

For issues with:
- **This setup**: Create an issue in this repository
- **Specific MCP servers**: Check their individual GitHub repositories
- **Claude Code**: Refer to official Claude Code documentation