terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_client_config" "example" {}

data "azurerm_key_vault" "example" {
  name                = var.key_vault_name
  resource_group_name = "afz-secure-resources-rg"  // Correct resource group name
}

data "azurerm_key_vault_secret" "admin_username" {
  name         = "adminUsername"
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "admin_password" {
  name         = "adminPassword"
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "server_admin_username" {
  name         = "serverAdminUsername"
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "server_admin_password" {
  name         = "serverAdminPassword"
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "vm_admin_username" {
  name         = "vmAdminUsername"
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "vm_admin_password" {
  name         = "vmAdminPassword"
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "vpn_shared_key" {
  name         = "vpnSharedKey"
  key_vault_id = data.azurerm_key_vault.example.id
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

module "vm" {
  source              = "./modules/vm"
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.vnet.subnet_ids["webapp"]
  admin_username      = data.azurerm_key_vault_secret.vm_admin_username.value
  admin_password      = data.azurerm_key_vault_secret.vm_admin_password.value
}

module "nsg" {
  source              = "./modules/nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.vnet.subnet_ids["webapp"]
}

resource "azurerm_virtual_network_gateway_connection" "onprem_to_main" {
  name                = "onprem-to-main"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  type = "IPsec"

  virtual_network_gateway_id = azurerm_virtual_network_gateway.onprem_vpn_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.onprem.id

  shared_key = data.azurerm_key_vault_secret.vpn_shared_key.value
}