# RecorridasZOTPWeb

Para ejecutar todos estos comandos, pararse en el directorio de la app, donde esta el archivo Dockerfile

##########################################################################################
Desarrollo
##########################################################################################

- Iniciar la base de desarrollo
Crea la base o la rebuildea, le carga los datos de prueba, y levanta el server:
docker-compose -f docker-compose.yml -f docker-compose-initDB-dev.yml up

- Actualizar la base de desarrollo
Corre el migrate db y levanta el server:
docker-compose up

- Borrar la db completa
sudo rm -R tmp/db

con eso borramos todos los archivos, ahora para dejar una db valida ejecutar:
docker-compose run db

Esperar a que termine y cerrarlo

- Probar el ambiente de produccion localmente
docker-compose -f docker-compose-prod-test.yml up

##########################################################################################
Produccion
##########################################################################################

#TODO

##########################################################################################
Docker
##########################################################################################

- Build image
sudo docker-compose build

- Ver containers en ejecucion
docker container ls

- Ejecutar en un contenedor
sudo docker exec -it f86f2498600e /bin/bash

- Parar un contenedor
docker container stop f86f2498600e

- Parar todos los contenedores
docker stop $(docker ps -a -q)

- Eliminar todos los contenedores
docker rm $(docker ps -a -q)