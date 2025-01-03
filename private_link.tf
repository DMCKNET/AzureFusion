resource "azurerm_private_dns_zone" "sql_zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "sql_link" {
  name                  = "example-link"
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.sql_zone.name
  virtual_network_id    = azurerm_virtual_network.main.id
}

resource "azurerm_private_dns_a_record" "sql_record" {
  name                = "mycustomdomain"
  zone_name           = azurerm_private_dns_zone.sql_zone.name
  resource_group_name = azurerm_resource_group.main.name
  ttl                 = 300
  records             = ["10.0.1.10"]  # Example IP address
}
