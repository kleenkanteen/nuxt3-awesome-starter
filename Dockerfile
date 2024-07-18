FROM node:18.2.0-alpine3.15 AS base
WORKDIR /usr/src/app

COPY package*.json ./

# Build
FROM base as build

RUN npm install --omit=dev

COPY . .

RUN npm run build

# Run
FROM base

ENV NODE_ENV=production
ENV PORT=$PORT

COPY --from=build /usr/src/app/.output /usr/src/app/.output

CMD [ "node", ".output/server/index.mjs" ]
