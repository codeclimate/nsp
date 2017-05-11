FROM node:8.2-alpine

WORKDIR /usr/src/app

COPY package.json ./

RUN apk --update add curl && \
    npm install --quiet && \
    npm run setup-offline && \
    apk del curl && \
    rm -rf /var/cache/apk

RUN adduser -u 9000 -D app
COPY . ./
RUN chown -R app:app ./

USER app

VOLUME /code
WORKDIR /code

CMD ["/usr/src/app/bin/nsp", "check", "--offline", "--warn-only", "--output", "codeclimate"]
