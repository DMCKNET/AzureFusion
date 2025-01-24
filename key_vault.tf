// This file defines the Azure Key Vault and its access policies, as well as data sources for retrieving
// the SSL certificate and its password from the Key Vault. The Key Vault is used to securely store
// secrets and certificates needed for the Azure Application Gateway.

resource "azurerm_key_vault" "example" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"

  purge_protection_enabled    = true

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.service_principal_object_id

    certificate_permissions = [
      "Get",
      "List",
      "Import",
      "Create",
      "Update",
      "Recover"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete"
    ]
  }
}

data "azurerm_key_vault" "example" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_certificate" "appgateway_ssl_cert" {
  name         = "appgateway-ssl-cert"
  key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "ssl_certificate_password" {
  name         = "appgateway-ssl-cert-password"
  key_vault_id = data.azurerm_key_vault.example.id
}