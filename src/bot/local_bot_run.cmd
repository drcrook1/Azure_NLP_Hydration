docker stop bot
docker rm bot
docker build -t bot .
docker run --name bot -p 80:80 --env-file ./dev.env bot