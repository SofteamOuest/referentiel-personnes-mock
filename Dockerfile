FROM node:9.6-stretch

RUN git

ADD src .

CMD json-server --watch db.json  --routes routes.json

