docker stop nlph_upgrade
docker rm nlph_upgrade
docker build -t nlph_upgrade .
docker run --name nlph_upgrade --env-file ./dev.env nlph_upgrade /src/upgrade.sh