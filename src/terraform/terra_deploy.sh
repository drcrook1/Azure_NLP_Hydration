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
# Commented out as not dealing with remote state for now.
#terraform init -backend-config=storage_account_name="$TARGET_RS_STORAGE_ACCOUNT" -backend-config=container_name="$TARGET_RS_CONTAINER_NAME" -backend-config=key="$TARGET_RS_KEY" -backend-config=resource_group_name="$TARGET_RS_RG"

# Commented out as we are not dealing with already existing infrastructure
#terraform import azurerm_resource_group.rg /subscriptions/"$AZ_SUB_ID"/resourceGroups/"$PREFIX"-"$1" 2>/dev/null
terraform init
cecho "Completed Terraform Init..." $magenta

# cecho "Starting Terraform Plan..." $magenta
# terraform plan -out=tfplan.out -destroy
# cecho "Completed Terraform Plan..." $magenta

cecho "Starting Terraform Apply..." $magenta
terraform apply -auto-approve #"tfplan.out"
cecho "Completed Terraform Apply..." $magenta

cecho "Writing Key Outputs to Files for next stages" $magenta
# mkdir -p ~/.kube
terraform output luis_key