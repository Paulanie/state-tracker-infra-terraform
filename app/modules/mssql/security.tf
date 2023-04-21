resource "random_password" "admin_password" {
  length  = 32
  special = true
}

resource "azurerm_key_vault_secret" "sql_server_admin_username" {
  key_vault_id = var.key_vault_id
  name         = "${var.server_name}-admin-username"
  value        = "sqladmin"
}

resource "azurerm_key_vault_secret" "sql_server_admin_password" {
  key_vault_id = var.key_vault_id
  name         = "${var.server_name}-admin-password"
  value        = random_password.admin_password.result
}

resource "azurerm_mssql_firewall_rule" "azures_services" {
  end_ip_address   = "0.0.0.0"
  name             = "azure-services"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
}

resource "azurerm_mssql_firewall_rule" "whitelist" {
  for_each = var.ip_whitelist

  end_ip_address   = each.value
  name             = each.key
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = each.value
}