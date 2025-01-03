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
  tenant_id       = var.tenant_id
  features {}
}

data "azurerm_client_config" "example" {}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "AzureFuzionRG"
  location = var.location
}
