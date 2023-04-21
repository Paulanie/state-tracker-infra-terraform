output "sql_server_name" {
  value = azurerm_mssql_server.sql_server.name
}

output "sql_server_admin_user_secret" {
  value = azurerm_key_vault_secret.sql_server_admin_username.name
}

output "sql_server_admin_password_secret" {
  value = azurerm_key_vault_secret.sql_server_admin_password.name
}