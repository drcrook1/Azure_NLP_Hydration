#!/bin/bash

red=$'\e[1;31m'
green=$'\e[1;32m'
blue=$'\e[1;34m'
magenta=$'\e[1;35m'
cyan=$'\e[1;36m'
white=$'\e[0m'

cecho ()                     # Color-echo.
                             # Argument $1 = message
                             # Argument $2 = color
{

  message=${1}   # Defaults to default message.
  color=${2}           # Defaults to black, if not specified.

  echo $color "$message" $white

  return
}

cecho "Beginning Deploy Process..." $green
POSTFIX=two

cd /src/terraform
echo $PWD
bash terra_deploy.sh $POSTFIX
cecho "Completed Initial Deploy Process..." $green

TERRA_OUTPUT=$(cat /src/terraform/terra_output_$POSTFIX.json)

cecho $TERRA_OUTPUT $magenta

mkdir /src/cogsvc_data/out/en-us
bf luis:convert --in /src/cogsvc_data/en-us/base.lu --culture "en-us" --out /src/cogsvc_data/out/en-us/base.lu
bf --help