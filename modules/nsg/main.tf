resource "azurerm_network_security_group" "admin_nsg" {
  name                = var.nsg_names["admin"]
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-ssh-rdp"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "3389"]
    source_address_prefix      = "192.168.1.0/24" # Replace with your trusted IP range
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "deny-all"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "admin_nsg_association" {
  subnet_id                 = var.subnet_ids["admin"]
  network_security_group_id = azurerm_network_security_group.admin_nsg.id
}

resource "azurerm_network_security_group" "webapp_nsg" {
  name                = var.nsg_names["webapp"]
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-https"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["443"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "deny-all"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "webapp_nsg_association" {
  subnet_id                 = var.subnet_ids["webapp"]
  network_security_group_id = azurerm_network_security_group.webapp_nsg.id
}

resource "azurerm_network_security_group" "database_nsg" {
  name                = var.nsg_names["database"]
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "allow-webapp-to-db"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.subnet_prefixes["webapp"]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "deny-all"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "database_nsg_association" {
  subnet_id                 = var.subnet_ids["database"]
  network_security_group_id = azurerm_network_security_group.database_nsg.id
}