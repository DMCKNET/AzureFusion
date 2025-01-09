resource "azurerm_lb" "main" {
  name                = var.lb_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  frontend_ip_configuration {
    name                 = var.lb_frontend_ip_name
    public_ip_address_id = azurerm_public_ip.load_balancer_pip.id
  }
}

resource "azurerm_public_ip" "load_balancer_pip" {
  name                = var.public_ip_names["lb"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
}

resource "azurerm_lb_backend_address_pool" "main" {
  name            = var.lb_backend_pool_name
  loadbalancer_id = azurerm_lb.main.id
}

resource "azurerm_lb_rule" "http_rule" {
  name                           = var.lb_rule_name
  loadbalancer_id                = azurerm_lb.main.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.lb_frontend_ip_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.main.id]
}

resource "azurerm_network_interface_backend_address_pool_association" "webapp_vm_nic_association" {
  network_interface_id   = module.vm.nic_id
  ip_configuration_name  = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
}