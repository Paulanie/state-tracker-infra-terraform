terraform {
  backend "azurerm" {
    resource_group_name  = "<%= expansion(':APP-:ENV') %>"
    storage_account_name = "<%= expansion(':APP:ENV').gsub! '-', '' %>"
    container_name       = "terraform-state"
    key                  = "<%= expansion(':PROJECT/:LOCATION/:APP/:ROLE/:ENV/:EXTRA/:BUILD_DIR/terraform.tfstate') %>"
  }
}
