resource "azurerm_cosmosdb_sql_database" "state_tracker_database" {
  account_name        = module.cosmosdb.cosmos_account_name
  name                = "state-tracker"
  resource_group_name = azurerm_resource_group.state_tracker.name
}

resource "azurerm_cosmosdb_sql_container" "amendments_container" {
  account_name        = module.cosmosdb.cosmos_account_name
  database_name       = azurerm_cosmosdb_sql_database.state_tracker_database.name
  name                = "amendments"
  partition_key_path  = "/cycleDeVie/dateDepot"
  resource_group_name = azurerm_resource_group.state_tracker.name

  indexing_policy {
    indexing_mode = "consistent"

    composite_index {
      index {
        order = "Descending"
        path  = "/cycleDeVie/datePublication"
      }
      index {
        order = "Descending"
        path  = "/cycleDeVie/dateSort"
      }
    }
  }

  unique_key {
    paths = ["/uid"]
  }
}