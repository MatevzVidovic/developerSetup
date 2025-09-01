FROM node:18-slim

# Install git and GitHub CLI
RUN apt-get update && apt-get install -y git curl
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& apt-get update \
&& apt-get install gh -y

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Set up token authentication
ENV GH_TOKEN_FILE=/run/secrets/gh_token
RUN echo "gh auth login --with-token < ${GH_TOKEN_FILE}" > /usr/local/bin/auth.sh && chmod +x /usr/local/bin/auth.sh

EXPOSE 3000
CMD ["node", "dist/index.js"]
