resource "azurerm_network_interface" "webapp_nic" {
  name                = "webapp-nic"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.webapp.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "webapp_vm" {
  name                  = "webapp-vm"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.webapp_nic.id]
  vm_size               = "Standard_DS1_v2"

  storage_os_disk {
    name              = "webapp_os_disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "webappvm"
    admin_username = data.azurerm_key_vault_secret.vm_admin_username.value
    admin_password = data.azurerm_key_vault_secret.vm_admin_password.value
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}