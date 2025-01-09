provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

data "azurerm_key_vault" "main" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group
}

data "azurerm_key_vault_secret" "vm_admin_username" {
  name         = "vmAdminUsername"
  key_vault_id = data.azurerm_key_vault.main.id
}

data "azurerm_key_vault_secret" "vm_admin_password" {
  name         = "vmAdminPassword"
  key_vault_id = data.azurerm_key_vault.main.id
}

data "azurerm_key_vault_secret" "vpn_shared_key" {
  name         = "vpnSharedKey"
  key_vault_id = data.azurerm_key_vault.main.id
}

output "vm_admin_username" {
  value = nonsensitive(data.azurerm_key_vault_secret.vm_admin_username.value)
}

output "vm_admin_password" {
  value = nonsensitive(data.azurerm_key_vault_secret.vm_admin_password.value)
}

output "vpn_shared_key" {
  value = nonsensitive(data.azurerm_key_vault_secret.vpn_shared_key.value)
}

module "vnet" {
  source              = "./modules/vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnet_names        = var.subnet_names
}

module "vm" {
  source              = "./modules/vm"
  vm_name             = var.vm_name
  vm_size             = "Standard_DS1_v2"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = module.vnet.subnet_ids["webapp-subnet"]
  admin_username      = data.azurerm_key_vault_secret.vm_admin_username.value
  admin_password      = data.azurerm_key_vault_secret.vm_admin_password.value
  nic_name            = var.nic_name
  prefix              = var.prefix
}