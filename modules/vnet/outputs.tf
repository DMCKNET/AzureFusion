output "vnet_id" {
  value = azurerm_virtual_network.afz_vnet.id
}

output "subnet_ids" {
  value = {
    webapp   = azurerm_subnet.afz_webapp_subnet.id
    database = azurerm_subnet.afz_database_subnet.id
    admin    = azurerm_subnet.afz_admin_subnet.id
  }
}
