FROM node:9.6-stretch

RUN npm install -g json-server

ADD src .

CMD json-server --watch db.json  --routes routes.json

