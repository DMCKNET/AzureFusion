/*
This Terraform configuration file defines resources for managing DNS and routing within an Azure environment. The resources include:

1. Private DNS Zone:
   - azurerm_private_dns_zone.example: Creates a private DNS zone named `fusion.private` within the specified resource group.

2. Private DNS Zone Virtual Network Links:
   - azurerm_private_dns_zone_virtual_network_link.example_link_vnet1: Links the private DNS zone to the virtual network specified by `module.vnet.vnet_id`.
   - azurerm_private_dns_zone_virtual_network_link.example_link_vnet2: Links the private DNS zone to the on-premises virtual network specified by `azurerm_virtual_network.onprem.id`.

3. Private DNS A Record:
   - azurerm_private_dns_a_record.example_record: Creates an A record named `fusion-record` within the private DNS zone, pointing to the IP address `10.0.1.10`.

4. Route Table:
   - azurerm_route_table.example: Creates a route table named `example-route-table` within the specified resource group and location. It includes a route named `route-to-vnet2` that directs traffic to the address space `10.1.0.0/16` via a virtual network gateway.

5. Subnet Route Table Association:
   - azurerm_subnet_route_table_association.example: Associates the route table with the `webapp` subnet in the virtual network.
*/

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