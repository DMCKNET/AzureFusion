output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "virtual_network_name" {
  value = module.vnet.vnet_id
}

output "subnet_ids" {
  value = module.vnet.subnet_ids
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "nic_id" {
  value = azurerm_network_interface.main.id
}

output "vm_id" {
  value = azurerm_virtual_machine.main.id
}

output "nic_id_2" {
  value = azurerm_network_interface.main_2.id
}

output "vm_id_2" {
  value = azurerm_virtual_machine.main_2.id
}