FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Clean up dev dependencies after build
RUN npm prune --production && npm cache clean --force

EXPOSE 3000

CMD ["npm", "start"]