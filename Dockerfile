FROM node:18.2.0-alpine3.15 AS base
WORKDIR /usr

ENV NODE_ENV=production

# Build
FROM base as build

RUN npm install --omit=dev

RUN npm run build
RUN npm prune

# Run
FROM base

ENV PORT=$PORT

COPY --from=build .output .output
# Optional, only needed if you rely on unbundled dependencies
# COPY --from=build /src/node_modules /src/node_modules

CMD [ "node", ".output/server/index.mjs" ]
