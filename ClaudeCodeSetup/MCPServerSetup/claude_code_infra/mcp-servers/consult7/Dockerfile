FROM node:18-alpine

WORKDIR /app

# Install git
RUN apk add --no-cache git

# Clone and install consult7
RUN git clone https://github.com/szeider/consult7.git .
RUN npm install

# Expose port
EXPOSE 3000

# Start the server
CMD ["npm", "start"]