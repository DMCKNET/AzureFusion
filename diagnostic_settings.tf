resource "azurerm_monitor_diagnostic_setting" "example" {
  name                       = "example-diagnostic-setting"
  target_resource_id         = azurerm_virtual_machine.main.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  metric {
    category = "AllMetrics"
    enabled  = true
  }
}