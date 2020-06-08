FROM ubuntu:18.04

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install curl -y

RUN apt-get install nodejs -y

COPY ./src /src

RUN chmod +x /src/deploy.sh
RUN chmod +x /src/upgrade.sh

CMD [ "/src/deploy.sh" ]