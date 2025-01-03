terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
  subscription_id = "970b1e0b-75cb-4721-99df-45bf7e5fb2c1"
  tenant_id       = "9ad50b1c-d7aa-46a5-96a9-6509fcc6b905"
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "AzureFuzionRG"
  location = var.location
}
