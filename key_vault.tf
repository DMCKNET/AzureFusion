data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "example" {
  name                        = "AzureFusionKeyVault"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"

  purge_protection_enabled    = true

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    certificate_permissions = [
      "Get",
      "List",
      "Import",
      "Delete",
      "Create",
      "Update",
      "ManageContacts",
      "GetIssuers",
      "ListIssuers",
      "SetIssuers",
      "DeleteIssuers",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
    ]
  }
}

data "azurerm_key_vault_secret" "ssl_certificate_password" {
  name         = "appgateway-ssl-cert-password"
  key_vault_id = azurerm_key_vault.example.id
}

resource "azurerm_key_vault_certificate" "appgateway_ssl_cert" {
  name         = "appgateway-ssl-cert"
  key_vault_id = azurerm_key_vault.example.id

  certificate {
    contents = filebase64("${path.module}/certs/appgateway.pfx")
    password = data.azurerm_key_vault_secret.ssl_certificate_password.value
  }
}