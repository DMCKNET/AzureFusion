resource "azurerm_virtual_network" "onprem" {
  name                = "onprem-vnet"
  address_space       = ["10.2.0.0/16"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_subnet" "onprem_subnet" {
  name                 = "onprem-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.onprem.name
  address_prefixes     = ["10.2.1.0/24"]
}

resource "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.onprem.name
  address_prefixes     = ["10.2.2.0/27"]
}

resource "azurerm_public_ip" "onprem_vpn_gateway_ip" {
  name                = "onprem-vpn-gateway-pip"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
}

resource "azurerm_virtual_network_gateway" "onprem_vpn_gateway" {
  name                = "onprem-vpn-gateway"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false

  sku = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.onprem_vpn_gateway_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway_subnet.id
  }
}

resource "azurerm_local_network_gateway" "onprem" {
  name                = "onprem-local-network-gateway"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  gateway_address = "52.191.58.105"  # Unique public IP for the Local Network Gateway
  address_space   = ["10.1.0.0/16"]
}

resource "azurerm_virtual_network_gateway_connection" "onprem_to_main" {
  name                = "onprem-to-main"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  type = "IPsec"

  virtual_network_gateway_id = azurerm_virtual_network_gateway.onprem_vpn_gateway.id
  local_network_gateway_id   = azurerm_local_network_gateway.onprem.id

  shared_key = "YourSharedKeyHere"
}
