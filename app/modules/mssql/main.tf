resource "azurerm_mssql_server" "sql_server" {
  name                         = "${var.server_name}-mssql"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = random_password.admin_password.result
  minimum_tls_version          = "1.2"
}

resource "azurerm_mssql_database" "sql_databases" {
  for_each = var.databases

  name                 = each.key
  zone_redundant       = false
  sku_name             = each.value["sku"]
  storage_account_type = "Local"
  server_id            = azurerm_mssql_server.sql_server.id
  geo_backup_enabled   = false
}