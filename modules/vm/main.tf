resource "azurerm_network_interface" "afz_webapp_nic" {
  name                = "${var.vm_name}-nic-dev"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "afz_webapp_vm" {
  name                  = "${var.vm_name}-dev"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.afz_webapp_nic.id]
  vm_size               = var.vm_size

  storage_os_disk {
    name              = "${var.vm_name}_os_disk-dev"
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
    computer_name  = "${var.vm_name}-dev"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_virtual_machine_extension" "afz_custom_script_extension" {
  name                 = "afzCustomScript"
  virtual_machine_id   = azurerm_virtual_machine.afz_webapp_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "fileUris": ["https://example.com/script.sh"],
        "commandToExecute": "sh script.sh"
    }
  SETTINGS
}
