locals {
  keyvault_entries = yamldecode(file("${path.module}/files/keyvault_entries.yaml"))
}

resource "azurerm_key_vault_secret" "secret" {
  for_each = local.keyvault_entries

  name         = each.key
  value        = each.value
  key_vault_id = module.keyvault.keyvault_id
}