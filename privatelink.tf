resource "azurerm_private_dns_zone" "sql_zone" {
  name                = "fusion.private"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_link" {
  name                  = "fusion-link"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.sql_zone.name
  virtual_network_id    = module.vnet.vnet_id
}

resource "azurerm_private_dns_a_record" "sql_record" {
  name                = "fusion-record"
  zone_name           = azurerm_private_dns_zone.sql_zone.name
  resource_group_name = azurerm_resource_group.main.name
  ttl                 = 300
  records             = ["10.0.1.10"]
}