resource "azurerm_mssql_server" "main" {
  name                         = "azurefuzion-sqlserver" 
  resource_group_name          = azurerm_resource_group.main.name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_username
  administrator_login_password = var.sql_admin_password
}

resource "azurerm_mssql_database" "main" {
  name      = "example-sqldb"
  server_id = azurerm_mssql_server.main.id
  sku_name  = "Basic"
}
