resource "azurerm_storage_account" "storage" {
  name                      = replace("${var.name}-storage", "-", "")
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true
}
