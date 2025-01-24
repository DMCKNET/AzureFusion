resource "azurerm_private_dns_zone" "example" {
  name                = "fusion.private"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "example_link_vnet1" {
  name                  = "fusion-link-vnet1"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = module.vnet.vnet_id
}

resource "azurerm_private_dns_zone_virtual_network_link" "example_link_vnet2" {
  name                  = "fusion-link-vnet2"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = azurerm_virtual_network.onprem.id
}

resource "azurerm_private_dns_a_record" "example_record" {
  name                = "fusion-record"
  zone_name           = azurerm_private_dns_zone.example.name
  resource_group_name = azurerm_resource_group.main.name
  ttl                 = 300
  records             = ["10.0.1.10"]
}

resource "azurerm_route_table" "example" {
  name                = "example-route-table"
  location            = var.location
  resource_group_name = var.resource_group_name

  route {
    name                   = "route-to-vnet2"
    address_prefix         = "10.1.0.0/16"  # Address space of the other VNet
    next_hop_type          = "VirtualNetworkGateway"
  }
}

resource "azurerm_subnet_route_table_association" "example" {
  subnet_id      = module.vnet.subnet_ids["webapp"] 
  route_table_id = azurerm_route_table.example.id
}