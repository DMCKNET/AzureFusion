data "azurerm_virtual_network" "fusion_vnet" {
  name                = var.fusion_vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_virtual_network" "onprem_vnet" {
  name                = var.onprem_vnet_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone" "sql_zone" {
  name                = "fusion.private"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_link_vnet1" {
  name                  = "fusion-link-vnet1"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.sql_zone.name
  virtual_network_id    = data.azurerm_virtual_network.fusion_vnet.id
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_link_vnet2" {
  name                  = "fusion-link-vnet2"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.sql_zone.name
  virtual_network_id    = data.azurerm_virtual_network.onprem_vnet.id
}

resource "azurerm_private_dns_a_record" "sql_record" {
  name                = "fusion-record"
  zone_name           = azurerm_private_dns_zone.sql_zone.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = ["10.0.1.10"]
}