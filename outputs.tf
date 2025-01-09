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