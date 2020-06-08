variable "resourcegroup" {
  description   = "Target Resource Group to deploy to"
  default       = "dacrook-nlph-1"
}

variable "prefix" {
  description   = "Target Resource Group to deploy to"
  default       = "dacrooknlph"
}

variable "postfix" {
  description   = "Target Resource Group to deploy to"
  default       = "1"
}

variable "location" {
  description   = "Azure region for resources"
  default       = "eastus"
}