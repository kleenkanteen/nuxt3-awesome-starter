FROM node:18.2.0-alpine.15 AS base
WORKDIR /usr/src/app

ENV NODE_ENV=production

WORKDIR /usr/src/app

# Build
FROM base as build

RUN npm install --production=true

RUN npm run build
RUN npm prune

# Run
FROM base

ENV PORT=$PORT

COPY --from=build /src/.output /src/.output
# Optional, only needed if you rely on unbundled dependencies
# COPY --from=build /src/node_modules /src/node_modules

CMD [ "node", ".output/server/index.mjs" ]
