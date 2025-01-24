/*
This Terraform configuration file defines a resource for managing an Azure Log Analytics Workspace.
*/
resource "azurerm_log_analytics_workspace" "main" {
  name                = "${var.prefix}-log-analytics"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30  
}