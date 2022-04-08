FROM node:17 AS build

WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install
COPY . .
RUN yarn build

FROM caddy/caddy:alpine
WORKDIR /app

COPY Caddyfile ./
COPY --from=build /app/dist ./dist

CMD [ "caddy", "run" ]