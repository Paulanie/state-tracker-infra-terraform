output "cosmos_account_id" {
  value = azurerm_cosmosdb_account.db.id
}

output "cosmos_account_connection_string" {
  value = azurerm_cosmosdb_account.db.primary_sql_connection_string
}

output "cosmos_account_name" {
  value = azurerm_cosmosdb_account.db.name
}