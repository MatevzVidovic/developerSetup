#!/bin/bash

# MCP Server Setup Script for WSL
# This script sets up all MCP servers using Docker and configures Claude Code

set -e  # Exit on any error

echo "🚀 Setting up MCP Servers for Claude Code..."

# Check if Docker is running
if ! docker info >/dev/null 2>&1; then
    echo "❌ Docker is not running. Please start Docker and try again."
    exit 1
fi

# Check if docker-compose is available
if ! command -v docker-compose >/dev/null 2>&1; then
    echo "❌ docker-compose is not installed. Please install it and try again."
    exit 1
fi

echo "✅ Docker is running"

# Create .env files from templates if they don't exist
create_env_files() {
    echo "📝 Creating environment files..."
    
    # Zen MCP .env
    if [ ! -f "./claude_code_infra/mcp-servers/zen/.env" ]; then
        cp "./claude_code_infra/mcp-servers/zen/.env.example" "./claude_code_infra/mcp-servers/zen/.env"
        echo "Created zen/.env from template"
    fi
    
    # GitHub MCP .env  
    if [ ! -f "./claude_code_infra/mcp-servers/github/.env" ]; then
        cp "./claude_code_infra/mcp-servers/github/.env.example" "./claude_code_infra/mcp-servers/github/.env"
        echo "Created github/.env from template"
    fi
    
    # Google Keep MCP .env
    if [ ! -f "./claude_code_infra/mcp-servers/google-keep/.env" ]; then
        cp "./claude_code_infra/mcp-servers/google-keep/.env.example" "./claude_code_infra/mcp-servers/google-keep/.env"
        echo "Created google-keep/.env from template"
    fi
    
    # Atlassian MCP .env
    if [ ! -f "./claude_code_infra/mcp-servers/atlassian/.env" ]; then
        cp "./claude_code_infra/mcp-servers/atlassian/.env.example" "./claude_code_infra/mcp-servers/atlassian/.env"
        echo "Created atlassian/.env from template"
    fi
}

# Build Docker images
build_images() {
    echo "🏗️  Building Docker images..."
    cd claude_code_infra
    
    # Build all services
    docker-compose build --no-cache
    
    echo "✅ All Docker images built successfully"
    cd ..
}

# Start MCP servers
start_servers() {
    echo "🚀 Starting MCP servers..."
    cd claude_code_infra
    
    # Start all services in detached mode
    docker-compose up -d
    
    echo "✅ All MCP servers started"
    
    # Wait a moment for services to start
    sleep 5
    
    # Check if services are running
    echo "📊 Checking service status..."
    docker-compose ps
    
    cd ..
}

# Install additional MCP servers (Node.js based)
install_node_mcps() {
    echo "📦 Installing Node.js MCP servers..."
    
    # Note: WebSearch is already built into Claude Code
    echo "ℹ️  WebSearch is built into Claude Code"
    
    # Install filesystem MCP server (if available and permissions allow)
    if npm view @modelcontextprotocol/server-filesystem >/dev/null 2>&1; then
        if ! npm list -g @modelcontextprotocol/server-filesystem >/dev/null 2>&1; then
            if sudo -n true 2>/dev/null; then
                sudo npm install -g @modelcontextprotocol/server-filesystem
                echo "✅ Filesystem MCP installed with sudo"
            else
                echo "ℹ️  Filesystem MCP requires sudo permissions to install globally"
                echo "ℹ️  You can install it later with: sudo npm install -g @modelcontextprotocol/server-filesystem"
            fi
        else
            echo "✅ Filesystem MCP already installed"
        fi
    else
        echo "ℹ️  Filesystem MCP not available in npm registry"
    fi
}

# Setup additional MCP servers from GitHub repos
setup_additional_servers() {
    echo "🔧 Setting up additional MCP servers..."
    echo "ℹ️  These are optional advanced servers - skipping for now"
    echo "ℹ️  Your core MCP servers (Zen, GitHub, Google Keep, Atlassian) are ready!"
    echo ""
    echo "📚 To enable advanced servers later:"
    echo "   - Context7: Library documentation lookup" 
    echo "   - Playwright: Browser automation"
    echo "   - Serena: Semantic code understanding"
    echo "   - Consult7: Advanced AI consultation"
    echo ""
    echo "   See README.md for manual setup instructions"
    
    # Create placeholder directory for future use
    mkdir -p additional_mcp_servers
    echo "✅ Placeholder created for future advanced MCP servers"
}

# Main execution
main() {
    echo "Starting MCP Server Setup..."
    
    create_env_files
    build_images
    start_servers
    install_node_mcps
    setup_additional_servers
    
    echo ""
    echo "🎉 MCP Server setup completed successfully!"
    echo ""
    echo "📋 Next steps:"
    echo "1. Edit the .env files in claude_code_infra/mcp-servers/*/. env with your API keys"
    echo "2. Restart the services: cd claude_code_infra && docker-compose restart"
    echo "3. Copy the .mcp.json to your Claude Code settings directory"
    echo "4. Start Claude Code and the MCP servers will be available"
    echo ""
    echo "🔗 Available services:"
    echo "   - Zen MCP: localhost:3001"
    echo "   - GitHub MCP: localhost:3003" 
    echo "   - Google Keep MCP: localhost:3004"
    echo "   - Atlassian MCP: localhost:3005"
    echo ""
    echo "📚 Check README.md for detailed configuration instructions"
}

# Run main function
main