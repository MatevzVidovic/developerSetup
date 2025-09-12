FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm install

# Copy source code
COPY src/ ./src/

# Expose port
EXPOSE 3000

# Start the server
CMD ["npm", "start"]