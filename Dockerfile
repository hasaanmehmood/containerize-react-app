# 1. Build our production build
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json .
RUN npm ci

COPY . .
RUN npm run build

# 2. Serve the build with a nginx server

FROM nginx:1.27.0

COPY --from=build /app/build /usr/share/nginx/html
