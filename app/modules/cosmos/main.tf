resource "azurerm_cosmosdb_account" "db" {
  name                = "${var.name}-cosmos-account"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_free_tier = true
  ip_range_filter  = "0.0.0.0,79.85.156.31"

  capacity {
    total_throughput_limit = 1000
  }

  geo_location {
    failover_priority = 0
    location          = var.location
    zone_redundant    = false
  }

  consistency_policy {
    consistency_level = "Eventual"
  }
}