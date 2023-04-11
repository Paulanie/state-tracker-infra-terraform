resource "azurerm_resource_group" "state_tracker" {
  location = var.location
  name     = var.project_name
}

module "functionapp_storage" {
  source = "../../modules/storageaccount"

  location            = var.location
  name                = "functionappstorage"
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
}

module "cosmosdb" {
  source              = "../../modules/cosmos"
  location            = var.location
  name                = var.project_name
  resource_group_name = azurerm_resource_group.state_tracker.name
}