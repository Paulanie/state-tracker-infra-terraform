data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault" {
  name                        = "${var.name}-keyvault"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
}

resource "azurerm_key_vault_access_policy" "main_access" {
  key_vault_id = azurerm_key_vault.keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get", "Backup", "Create", "List", "Purge", "Recover", "Restore", "Delete"
  ]

  secret_permissions = [
    "Get", "Backup", "List", "Purge", "Recover", "Restore", "Delete", "Set"
  ]

  storage_permissions = [
    "Get", "Backup", "List", "Purge", "Recover", "Restore", "Delete", "Set", "Update"
  ]
}