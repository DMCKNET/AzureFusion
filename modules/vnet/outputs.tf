output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "subnet_ids" {
  value = {
    webapp    = azurerm_subnet.webapp.id
    bastion   = azurerm_subnet.bastion.id
    gateway   = azurerm_subnet.gateway.id
    database  = azurerm_subnet.database.id
    admin     = azurerm_subnet.admin.id
    appgateway = azurerm_subnet.appgateway.id
  }
}