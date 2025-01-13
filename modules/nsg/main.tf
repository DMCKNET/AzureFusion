resource "azurerm_network_security_group" "admin" {
  name                = var.nsg_names["admin"]
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowSSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "admin" {
  subnet_id                 = module.vnet.subnet_ids["admin"]
  network_security_group_id = azurerm_network_security_group.admin.id
}

resource "azurerm_network_security_group" "webapp" {
  name                = var.nsg_names["webapp"]
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "webapp" {
  subnet_id                 = module.vnet.subnet_ids["webapp"]
  network_security_group_id = azurerm_network_security_group.webapp.id
}

resource "azurerm_network_security_group" "database" {
  name                = var.nsg_names["database"]
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "AllowSQL"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "database" {
  subnet_id                 = module.vnet.subnet_ids["database"]
  network_security_group_id = azurerm_network_security_group.database.id
}