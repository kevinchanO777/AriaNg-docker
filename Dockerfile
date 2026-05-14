FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM alpine:3.19
RUN apk add --no-cache aria2 python3
COPY --from=build /app/dist /app
COPY entrypoint.sh /entrypoint.sh
EXPOSE 9222 6800
CMD ["/entrypoint.sh"]
