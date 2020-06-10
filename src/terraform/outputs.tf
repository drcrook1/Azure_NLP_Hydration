output "luis_key" {
    value = azurerm_cognitive_account.luis.primary_access_key
}

output "luis_author_key" {
    value = azurerm_cognitive_account.luisauthor.primary_access_key
}


output "qna_key" {
    value = azurerm_cognitive_account.qna.primary_access_key
}