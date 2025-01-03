terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  features {}
}

data "azurerm_client_config" "example" {}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = "AzureFuzionRG"
  location = var.location
}

# Virtual Network Module
module "vnet" {
  source              = "./modules/vnet"
  vnet_name           = "afz_vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
}

# Virtual Machine Module
module "vm" {
  source              = "./modules/vm"
  vm_name             = "afz_webapp_vm"
  vm_size             = "Standard_DS1_v2"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = module.vnet.subnet_ids["webapp"]
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}

# Network Security Group Module
module "nsg" {
  source              = "./modules/nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = module.vnet.subnet_ids["webapp"]  # Added subnet_id argument
}

# Other resources (e.g., bastion host, load balancer, etc.)
# ...
