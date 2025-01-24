/*
This Terraform configuration file defines resources for managing an Azure Load Balancer and its associated components. The resources include:

1. Load Balancer:
   - azurerm_lb.main: Creates an Azure Load Balancer with a frontend IP configuration.

2. Backend Address Pool:
   - azurerm_lb_backend_address_pool.main: Creates a backend address pool for the load balancer.

3. Health Probe:
   - azurerm_lb_probe.main: Creates an HTTP health probe for the load balancer to monitor the health of the backend instances.

4. Load Balancer Rule:
   - azurerm_lb_rule.main: Creates a load balancing rule to distribute incoming traffic to the backend instances based on the health probe.
*/

resource "azurerm_lb" "main" {
  name                = var.lb_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  frontend_ip_configuration {
    name                 = var.lb_frontend_ip_name
    subnet_id            = module.vnet.subnet_ids["webapp"]  # Use the appropriate subnet ID for internal traffic
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "main" {
  name            = var.lb_backend_pool_name
  loadbalancer_id = azurerm_lb.main.id
}

resource "azurerm_lb_probe" "main" {
  name                = "http-probe"
  loadbalancer_id     = azurerm_lb.main.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "main" {
  name                           = var.lb_rule_name
  loadbalancer_id                = azurerm_lb.main.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.lb_frontend_ip_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.main.id]
  probe_id                       = azurerm_lb_probe.main.id
}

resource "azurerm_network_interface_backend_address_pool_association" "webapp_vm_nic_association" {
  count                   = 2
  network_interface_id    = element([azurerm_network_interface.main.id, azurerm_network_interface.main_2.id], count.index)
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
}