resource "azurerm_virtual_network" "afz_vnet" {
  name                = "${var.vnet_name}-dev"
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "afz_webapp_subnet" {
  name                 = "${var.vnet_name}-webapp-subnet-dev"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.afz_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "afz_database_subnet" {
  name                 = "${var.vnet_name}-database-subnet-dev"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.afz_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "afz_admin_subnet" {
  name                 = "${var.vnet_name}-admin-subnet-dev"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.afz_vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}