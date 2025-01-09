resource "azurerm_subnet" "onprem_subnet" {
  name                 = var.onprem_subnet_names["subnet1"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.onprem_vnet_name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_subnet" "gateway_subnet" {
  name                 = var.onprem_subnet_names["subnet2"]
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.onprem_vnet_name
  address_prefixes     = ["10.1.2.0/24"]
}