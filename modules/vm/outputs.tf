output "nic_id" {
  value = azurerm_network_interface.main.id
}

output "debug_admin_password" {
  value     = var.admin_password
  sensitive = true
}

output "vm_id" {
  value = azurerm_virtual_machine.main.id
}