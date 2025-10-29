FROM node:18-alpine

WORKDIR /app

# Install git
RUN apk add --no-cache git

# Clone and install SuperClaude Framework
RUN git clone https://github.com/SuperClaude-Org/SuperClaude_Framework.git .
RUN npm install

# Expose port
EXPOSE 3000

# Start the server
CMD ["npm", "start"]