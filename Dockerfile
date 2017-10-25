FROM node:8-alpine

RUN npm install -g json-server

ADD src .

CMD json-server --watch db.json  --routes routes.json

