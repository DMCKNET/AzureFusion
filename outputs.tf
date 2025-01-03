output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "virtual_network_name" {
  value = module.vnet.vnet_id
}

output "vnet_id" {
  value = module.vnet.vnet_id
}

output "subnet_ids" {
  value = module.vnet.subnet_ids
}

output "vm_id" {
  value = module.vm.vm_id
}

output "nic_id" {
  value = module.vm.nic_id
}

output "nsg_id" {
  value = module.nsg.nsg_id
}