locals {
  keyvault_entries = yamldecode(file("${path.module}/files/keyvault_entries.yaml"))
}

resource "azurerm_key_vault_secret" "raw_secret" {
  for_each = local.keyvault_entries

  name         = each.key
  value        = each.value
  key_vault_id = module.keyvault.keyvault_id
}

resource "azurerm_key_vault_secret" "cosmosdb_connection_string_secret" {
  name         = "cosmos-connection-string"
  value        = module.cosmosdb.cosmos_account_connection_string
  key_vault_id = module.keyvault.keyvault_id
}