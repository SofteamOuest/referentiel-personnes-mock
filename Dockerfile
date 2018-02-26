FROM node:9.6-stretch

CMD nmcli dev show | grep DNS

CMD ping registry.npmjs.org

RUN npm install -g json-server

ADD src .

CMD json-server --watch db.json  --routes routes.json

