resource "azurerm_mssql_server" "main" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = azurerm_resource_group.main.location
  version                      = "12.0"
  administrator_login          = data.azurerm_key_vault_secret.server_admin_username.value
  administrator_login_password = data.azurerm_key_vault_secret.server_admin_password.value
}

resource "azurerm_mssql_database" "main" {
  name      = var.sql_database_name
  server_id = azurerm_mssql_server.main.id
  sku_name  = "Basic"
}

data "azurerm_key_vault" "sql" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group
}

data "azurerm_key_vault_secret" "server_admin_username" {
  name         = "serverAdminUsername"
  key_vault_id = data.azurerm_key_vault.sql.id
}

data "azurerm_key_vault_secret" "server_admin_password" {
  name         = "serverAdminPassword"
  key_vault_id = data.azurerm_key_vault.sql.id
}

output "server_admin_username" {
  value = nonsensitive(data.azurerm_key_vault_secret.server_admin_username.value)
}

output "server_admin_password" {
  value = nonsensitive(data.azurerm_key_vault_secret.server_admin_password.value)
}