provider "azurerm" {
    version = "~> 2.3.0"
    features {}
}

resource "azurerm_resource_group" "rg" {
  name      = var.resourcegroup
  location  = var.location
}

resource "azurerm_storage_account" "storage" {
        name                                  =       "${var.prefix}storage${var.postfix}"
        resource_group_name                   =       azurerm_resource_group.rg.name
        location                              =       azurerm_resource_group.rg.location
        account_tier                          =       "Standard"
        account_replication_type              =       "LRS"
}

resource "azurerm_cognitive_account" "luis" {
  name                = "${var.prefix}luis${var.postfix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "LUIS"

  sku_name = "F0"

}

resource "azurerm_cognitive_account" "luisauthor" {
  name                = "${var.prefix}luisauth${var.postfix}"
  location            = "westus"
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "LUIS.Authoring"

  sku_name = "F0"

}

resource "azurerm_cognitive_account" "qna" {
  name                = "${var.prefix}qna${var.postfix}"
  location            = "westus"
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "QnAMaker"

  sku_name = "F0"

  qna_runtime_endpoint = "https://www.mysamplesite.com/api/v1/qna"

}