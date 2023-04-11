output "storage_id" {
  value = azurerm_storage_account.storage.id
}

output "storage_name" {
  value = azurerm_storage_account.storage.name
}

output "storage_access_key" {
  value = azurerm_storage_account.storage.primary_access_key
}