FROM node:9.6-stretch

RUN npm install -g json-server

ADD src .

CMD nmcli dev show | grep DNS

CMD ping registry.npmjs.org

CMD json-server --watch db.json  --routes routes.json

