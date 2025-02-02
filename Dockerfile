FROM node:22-alpine3.21 AS builder

WORKDIR /app

COPY yarn.lock package.json ./

RUN yarn install --frozen-lockfile

COPY . .

RUN yarn build

FROM httpd:2.4-alpine3.21 AS server

COPY --from=builder /app/dist/ /usr/local/apache2/htdocs/
