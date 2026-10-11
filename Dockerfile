FROM node:20-alpine AS dependencies
WORKDIR /app/server
COPY server/package.json server/package-lock.json ./
RUN npm ci --omit=dev

FROM node:20-alpine
ENV NODE_ENV=production
WORKDIR /app
COPY --from=dependencies --chown=node:node /app/server/node_modules ./server/node_modules
COPY --chown=node:node server ./server
COPY --chown=node:node public ./public
USER node
EXPOSE 3000
CMD ["node", "server/index.js"]
