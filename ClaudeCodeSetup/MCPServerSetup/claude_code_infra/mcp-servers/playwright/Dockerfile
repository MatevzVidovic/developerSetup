FROM node:18-slim

WORKDIR /app

# Install system dependencies for Playwright
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    ca-certificates \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libdrm2 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Clone and install playwright-mcp
RUN git clone https://github.com/microsoft/playwright-mcp.git .
RUN npm install

# Install Playwright browsers
ENV PLAYWRIGHT_BROWSERS_PATH=/app/browsers
RUN npx playwright install chromium firefox webkit
RUN npx playwright install-deps

# Expose port
EXPOSE 3000

# Start the server
CMD ["npm", "start"]