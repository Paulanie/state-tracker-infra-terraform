resource "azurerm_resource_group" "state_tracker" {
  location = var.location
  name     = var.project_name
}

module "functionapp_storage" {
  source = "../../modules/storageaccount"

  location            = var.location
  name                = "statetrackerapp"
  resource_group_name = azurerm_resource_group.state_tracker.name
}

module "keyvault" {
  source = "../../modules/keyvault"

  location            = var.location
  name                = var.project_name
  resource_group_name = azurerm_resource_group.state_tracker.name
}

module "functionapp" {
  source = "../../modules/functionapp"

  location            = var.location
  name                = var.project_name
  resource_group_name = azurerm_resource_group.state_tracker.name
  storage_access_key  = module.functionapp_storage.storage_access_key
  storage_name        = module.functionapp_storage.storage_name
  keyvault_id         = module.keyvault.keyvault_id

  app_settings = {
    AMENDMENTS_URL = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.raw_secret["amendements-url"].versionless_id}/)"
    COSMOS_ACCOUNT_CONNECTION_STRING = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.cosmosdb_connection_string_secret.versionless_id}/)"
  }
}

module "cosmosdb" {
  source              = "../../modules/cosmos"
  location            = var.location
  name                = var.project_name
  resource_group_name = azurerm_resource_group.state_tracker.name
}