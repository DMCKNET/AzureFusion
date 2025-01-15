resource "azurerm_monitor_metric_alert" "cpu_alert" {
  name                = "cpu-alert"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_virtual_machine.main.id]
  description         = "Alert when CPU usage exceeds 80%"
  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.example.id
  }

  tags = {
    environment = "development"
  }
}

resource "azurerm_monitor_action_group" "example" {
  name                = "example-action-group"
  resource_group_name = var.resource_group_name
  short_name          = "example"

  email_receiver {
    name          = "admin"
    email_address = "admin@example.com"
  }
}