resource "azurerm_virtual_network" "onprem" {
  name                = "onprem-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "onprem_subnet" {
  name                 = var.onprem_subnet_names["subnet1"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.onprem.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_subnet" "gateway_subnet" {
  name                 = var.onprem_subnet_names["subnet2"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.onprem.name
  address_prefixes     = ["10.1.2.0/24"]
}