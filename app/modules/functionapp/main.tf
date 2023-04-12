resource "azurerm_service_plan" "service_plan" {
  name                = "${var.name}-service-plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "function_app" {
  name                = "${var.name}-function-app"
  resource_group_name = var.resource_group_name
  location            = var.location

  storage_account_name       = var.storage_name
  storage_account_access_key = var.storage_access_key
  service_plan_id            = azurerm_service_plan.service_plan.id

  functions_extension_version = "~4"

  site_config {
    application_insights_connection_string = azurerm_application_insights.appinsights.connection_string
    application_insights_key               = azurerm_application_insights.appinsights.instrumentation_key
    application_stack {
      python_version = "3.10"
    }
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = var.app_settings
}

resource "azurerm_key_vault_access_policy" "function_app_keyvault_access" {
  count = var.keyvault_id != null ? 1 : 0

  key_vault_id = var.keyvault_id
  tenant_id    = azurerm_linux_function_app.function_app.identity[0].tenant_id
  object_id    = azurerm_linux_function_app.function_app.identity[0].principal_id

  secret_permissions = [
    "Get",
  ]
}
