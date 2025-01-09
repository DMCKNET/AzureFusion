output "subnet_ids" {
  value = {
    for subnet in [azurerm_subnet.webapp, azurerm_subnet.bastion, azurerm_subnet.gateway, azurerm_subnet.database, azurerm_subnet.admin] :
    "${subnet.name}" => subnet.id
  }
}

output "vnet_id" {
  value = azurerm_virtual_network.main.id
}