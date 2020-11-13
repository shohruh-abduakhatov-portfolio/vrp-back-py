docker pull mdillon/postgis
docker run --name wiut-postgis -e POSTGRES_PASSWORD=1qaz2wsx3edc -p 5431:5432 -d mdillon/postgis
docker container start wiut-postgis

