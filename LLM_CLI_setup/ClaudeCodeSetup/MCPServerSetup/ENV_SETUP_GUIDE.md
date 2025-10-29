# 🔧 Complete .env Configuration Guide

This guide shows you exactly how to set up each MCP server with your accounts and services.

## 📋 **Quick Setup Steps**

1. **Copy example files to .env files:**
   ```bash
   cd mcp-servers
   cp zen/.env.example zen/.env
   cp github/.env.example github/.env  
   cp google-keep/.env.example google-keep/.env
   cp atlassian/.env.example atlassian/.env
   ```

2. **Edit each .env file with your credentials** (see detailed instructions below)

3. **Restart the services:**
   ```bash
   cd .. && docker-compose restart
   ```

---

## 🧠 **1. Zen MCP (AI Model Consultation)**

**File**: `mcp-servers/zen/.env`

### Get a Free Gemini API Key (Recommended - Free!)
1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Click "Create API Key"
3. Copy your API key

### Edit zen/.env:
```bash
# For Google Gemini (FREE tier available!)
GEMINI_API_KEY=AIzaSyBob67HablaBlahBlahYourActualKeyHere

# Optional: For OpenAI (if you have credits)
# OPENAI_API_KEY=sk-proj-aBcDeFgHiJkLmNoPqRsTuVwXyZ123456789

# Optional: For OpenRouter (access to many models)  
# OPENROUTER_API_KEY=sk-or-v1-1234567890abcdef

# API configuration
PORT=3000
NODE_ENV=production
```

**Result**: Ask Claude to "Use Zen MCP to consult Gemini about..." and get responses from other AI models!

---

## 🐙 **2. GitHub MCP (Project Management)**

**File**: `mcp-servers/github/.env`

### Get GitHub Personal Access Token
1. Go to [GitHub Settings > Personal Access Tokens](https://github.com/settings/tokens)
2. Click "Generate new token (classic)"
3. Select scopes: `repo`, `read:user`, `user:email`
4. Copy your token

### Edit github/.env:
```bash
# Your GitHub Personal Access Token
GITHUB_TOKEN=ghp_1234567890abcdefghijklmnopqrstuvwxyz123

# API configuration
PORT=3000
NODE_ENV=production
```

**Result**: Ask Claude to "Create a GitHub issue for..." or "Show me issues in my repository..."

---

## 📝 **3. Google Keep MCP (Note-Taking)**

**File**: `mcp-servers/google-keep/.env`

This is more complex because Google Keep doesn't have a public API. You have a few options:

### Option A: Skip for now (Recommended)
Just comment out the google-keep section in docker-compose.yml and come back to this later.

### Option B: Set up Google OAuth (Advanced)
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing
3. Enable Google Keep API (if available)
4. Create OAuth 2.0 credentials
5. Get authorization code and exchange for refresh token

### Edit google-keep/.env:
```bash
# Google OAuth2 credentials (advanced setup required)
GOOGLE_CLIENT_ID=1234567890-abcdefghijklmnopqrstuvwxyz.apps.googleusercontent.com
GOOGLE_CLIENT_SECRET=GOCSPX-1234567890abcdefghijklmnop
GOOGLE_REFRESH_TOKEN=1//0abcdefghijklmnopqrstuvwxyz1234567890

# API configuration  
PORT=3000
NODE_ENV=production
```

**Note**: Google Keep API access is limited. Consider using this as a learning example.

---

## 🎯 **4. Atlassian/Jira MCP (Ticket Management)**

**File**: `mcp-servers/atlassian/.env`

### Get Atlassian API Token
1. Go to [Atlassian Account Settings](https://id.atlassian.com/manage-profile/security/api-tokens)
2. Click "Create API token"
3. Give it a label like "Claude MCP Server"
4. Copy your token

### Find Your Jira Details
- **Host**: Your Jira URL (e.g., `mycompany.atlassian.net`)
- **Email**: Your Atlassian account email
- **Projects**: Go to your Jira > Projects to see available project keys

### Edit atlassian/.env:
```bash
# Your Atlassian/Jira instance details
ATLASSIAN_HOST=mycompany.atlassian.net
ATLASSIAN_EMAIL=yourname@company.com
ATLASSIAN_API_TOKEN=ATATT3xFfGF0T4nBtCY4X-UUwzYZ123456789abcdef

# API configuration
PORT=3000
NODE_ENV=production

# Optional: Set defaults for your most-used project
DEFAULT_PROJECT_KEY=DEVOPS
DEFAULT_ISSUE_TYPE=Task
```

**Result**: Ask Claude to "Create a Jira ticket for..." or "Show me tickets assigned to me..."

---

## ✅ **Testing Your Configuration**

After setting up your `.env` files:

### 1. Restart the services:
```bash
docker-compose restart
```

### 2. Check if services are running:
```bash
docker-compose ps
```

### 3. Test individual services:
```bash
# Test Zen MCP
curl -s http://localhost:3001/health && echo " - Zen MCP: ✅"

# Test GitHub MCP  
curl -s http://localhost:3003/health && echo " - GitHub MCP: ✅"

# Test Google Keep MCP
curl -s http://localhost:3004/health && echo " - Google Keep MCP: ✅"

# Test Atlassian MCP
curl -s http://localhost:3005/health && echo " - Atlassian MCP: ✅"
```

### 4. Copy MCP config to Claude Code:
```bash
cp .mcp.json ~/.claude/
```

### 5. Start Claude Code and test:
- "Use Zen MCP to ask Gemini: What's the weather like?"
- "Create a GitHub issue titled 'Test issue from Claude'"
- "Create a Jira ticket for testing the MCP setup"

---

## 🚨 **Troubleshooting**

### Service won't start?
```bash
# Check logs for specific service
docker-compose logs zen-mcp
docker-compose logs github-mcp
docker-compose logs google-keep-mcp
docker-compose logs atlassian-mcp
```

### API key not working?
1. Double-check the key is copied correctly (no extra spaces)
2. Verify the key has the right permissions
3. Check if the service is accessible from your network

### Claude Code not seeing MCP servers?
1. Verify `.mcp.json` is in the right location (`~/.claude/`)
2. Restart Claude Code
3. Check Claude Code settings for MCP server configuration

---

## 🎯 **Recommended Order**

Start with these in order of easiness:

1. **✅ Zen MCP** - Easiest! Free Gemini API key
2. **✅ GitHub MCP** - Quick if you have GitHub account  
3. **✅ Atlassian MCP** - If you use Jira at work
4. **⏸️ Google Keep MCP** - Skip for now (complex setup)

---

## 💡 **Pro Tips**

- **Start with Zen MCP**: Get the free Gemini API key - it's the most useful!
- **Use environment variables**: Add API keys to your shell profile for easy access
- **Test one at a time**: Configure and test each service individually
- **Keep backups**: Save working `.env` files as `.env.backup`

---

**Need help?** Check the logs with `docker-compose logs [service-name]` or refer to the main README.md file!