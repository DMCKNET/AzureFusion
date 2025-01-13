resource "azurerm_bastion_host" "main" {
  name                = var.bastion_host_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = module.vnet.subnet_ids["bastion"]
    public_ip_address_id = azurerm_public_ip.bastion.id
  }

  depends_on = [module.vnet]
}