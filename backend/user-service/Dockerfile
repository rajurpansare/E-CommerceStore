# backend/user-service/Dockerfile
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy source code
COPY . .

EXPOSE 3001

CMD ["node", "server.js"]

#FROM node:18-alpine

#WORKDIR /app

#COPY package*.json ./

#RUN npm install

#COPY . .

#EXPOSE 3001

#CMD ["npm","start"]
