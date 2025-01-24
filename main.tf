terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.14.0"
    }
  }
  required_version = ">= 1.10.4"
}

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

resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_public_ip" "bastion" {
  name                = "${var.prefix}-bastion-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

module "vnet" {
  source              = "./modules/vnet"
  location            = var.location
  resource_group_name = var.resource_group_name
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnet_names        = var.subnet_names
}

resource "azurerm_network_interface" "main" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet.subnet_ids["webapp"]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = var.vm_size

  storage_os_disk {
    name              = "${var.prefix}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vm_name
    admin_username = nonsensitive(data.azurerm_key_vault_secret.vm_admin_username.value)
    admin_password = nonsensitive(data.azurerm_key_vault_secret.vm_admin_password.value)
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "development"
  }
}

resource "azurerm_network_interface" "main_2" {
  name                = var.nic_name_2
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.vnet.subnet_ids["webapp"]
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "main_2" {
  name                  = var.vm_name_2
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.main_2.id]
  vm_size               = var.vm_size

  storage_os_disk {
    name              = "${var.prefix}-osdisk-2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = var.vm_name_2
    admin_username = nonsensitive(data.azurerm_key_vault_secret.vm_admin_username.value)
    admin_password = nonsensitive(data.azurerm_key_vault_secret.vm_admin_password.value)
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {
    environment = "development"
  }
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
resource "azurerm_subnet" "example" {
  name                 = var.subnet_names["webapp"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_public_ip" "example" {
  name                = var.public_ip_names["lb"]
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}