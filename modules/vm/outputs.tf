output "vm_id" {
  value = azurerm_virtual_machine.afz_webapp_vm.id
}

output "nic_id" {
  value = azurerm_network_interface.afz_webapp_nic.id
}