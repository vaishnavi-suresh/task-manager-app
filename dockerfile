FROM node:22-alpine AS base
WORKDIR ./
COPY package*.json ./
RUN npm ci --omit=dev
COPY ./express-server ./express-server
EXPOSE 4001
CMD ["npm", "start"]
