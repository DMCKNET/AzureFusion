resource "azurerm_public_ip" "app_gateway" {
  name                = "${var.prefix}-app-gateway-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}