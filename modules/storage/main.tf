resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  enable_https_traffic_only = true

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  tags = {
    environment = "development"
  }
}