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

# Commented out as not dealing with remote state for now.
export ARM_CLIENT_ID="$SP_APP_ID"
export ARM_CLIENT_SECRET="$SP_APP_PW"
export ARM_SUBSCRIPTION_ID="$AZ_SUB_ID"
export ARM_TENANT_ID="$SP_APP_TENANT_ID"
# export ARM_ACCESS_KEY="$TARGET_RS_STORAGE_ACCESS_KEY"

export TF_VAR_location="$TARGET_LOCATION"
export TF_VAR_resourcegroup="$PREFIX-$1"
export TF_VAR_prefix="$PREFIX"
export TF_VAR_postfix="$1"

cecho "Starting Terraform Init..." $magenta
terraform init
cecho "Completed Terraform Init..." $magenta


cecho "Starting Terraform Apply..." $magenta
terraform apply -auto-approve
cecho "Completed Terraform Apply..." $magenta

cecho "Writing Key Outputs to Files for next stages" $magenta

LUIS_KEY=$(terraform output luis_key)
LUIS_AUTHOR_KEY=$(terraform output luis_author_key)
QNA_KEY=$(terraform output qna_key)

jq -n --arg luis_key  "{'keys': {'luis_key' : $LUIS_KEY, 'luis_author_key' : $LUIS_AUTHOR_KEY 'qna_key' : $QNA_KEY}" > /src/terraform/terra_output_$1.json