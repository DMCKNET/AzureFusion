resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.prefix}-log-analytics"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 7  # Set a shorter retention period to reduce costs

  tags = {
    environment = "development"
  }
}