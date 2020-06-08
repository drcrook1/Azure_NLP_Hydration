FROM ubuntu:18.04

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install wget gnupg unzip jq apt-transport-https dos2unix curl build-essential checkinstall libssl-dev -y

ENV TERRAFORM_VERSION="0.12.23"
RUN wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
RUN unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
RUN mv terraform /bin

RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN apt-get install nodejs npm -y
RUN npm install -g n
RUN n stable

RUN npm i -g @microsoft/botframework-cli

RUN apt-get update -y
RUN apt-get upgrade -y

COPY ./src /src

RUN chmod +x /src/deploy.sh
RUN chmod +x /src/upgrade.sh

CMD [ "/src/deploy.sh" ]