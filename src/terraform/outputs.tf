output "luis_key" {
    value = azurerm_cognitive_account.luis.primary_access_key
}

output "qma_key" {
    value = azurerm_cognitive_account.qna.primary_access_key
}