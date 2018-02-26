FROM elkouhen/json-server

ADD src .

CMD json-server --watch db.json  --routes routes.json

