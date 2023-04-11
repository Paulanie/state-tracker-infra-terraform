resource "azurerm_log_analytics_workspace" "loganalytics_workspace" {
  name                = "${var.name}-workspace"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "appinsights" {
  name                = "${var.name}-appinsights"
  resource_group_name = var.resource_group_name
  location            = var.location
  workspace_id        = azurerm_log_analytics_workspace.loganalytics_workspace.id
  application_type    = "other"
}