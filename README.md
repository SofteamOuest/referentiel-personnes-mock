# Moks de services REST

## Ces mock utilisent [json-server](https://github.com/typicode/json-server).

Installer json-server:

        npm install -g json-server

Ce mock est configuré pour répondre au service

        GET     /api/personnes
        GET     /api/personnes/{id}
        POST    /api/personnes
        DELETE  /api/personnes/{id}
        ...

Modifier le fichier routes.json pour personnaliser les routes.
Voir [add-custom-routes](https://github.com/typicode/json-server#add-custom-routes) pour plus d'informations.

Pour lancer les mocks:

        json-server --watch db.json  --routes routes.json
        
Pour utiliser les mocks avec de la basic auth:

        npm install -g basic-auth
        json-server --watch db.json --routes routes.json --middlewares auth.js

Le user et le mot de passe peuvent être configurés dans auth.js.
Par défaut c'est user:mdp

#### TODO      
Mettre en place jwt dans le mock?