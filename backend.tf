terraform {
  backend "azurerm" {
    resource_group_name   = "AzureFusionRG"
    storage_account_name  = "azfusionstorage"
    container_name        = "terraform-state"
    key                   = "terraform.tfstate"
  }
}