FROM node:alpine as builder
WORKDIR /app
ADD padckage*.json ./
RUN npm ci
RUN npm run build --prod

FROM nodeL:alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
ADD package*.json ./
RUN npm ci --omit=dev
CMD [ "node", "./dist/main.js" ]