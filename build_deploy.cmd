docker stop nlph_deploy
docker rm nlph_deploy
docker build -t nlph_deploy .
docker run --name nlph_deploy --env-file ./dev.env nlph_deploy