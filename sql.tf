data "azurerm_key_vault_secret" "sql_admin_username" {
  name         = "serverAdminUsername"
  key_vault_id = data.azurerm_key_vault.main.id
}

data "azurerm_key_vault_secret" "sql_admin_password" {
  name         = "serverAdminPassword"
  key_vault_id = data.azurerm_key_vault.main.id
}

resource "azurerm_mssql_server" "main" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = nonsensitive(data.azurerm_key_vault_secret.sql_admin_username.value)
  administrator_login_password = nonsensitive(data.azurerm_key_vault_secret.sql_admin_password.value)

  tags = {
    environment = "development"
  }
}

resource "azurerm_mssql_database" "main" {
  name      = "${var.prefix}-sqldb"
  server_id = azurerm_mssql_server.main.id
  sku_name  = "Basic"

  tags = {
    environment = "development"
  }
}