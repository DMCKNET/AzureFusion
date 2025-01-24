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
      "Update"
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

resource "azurerm_application_gateway" "example" {
  name                = "example-appgateway"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = azurerm_subnet.example.id
  }

  ssl_certificate {
    name     = "appgateway-ssl-cert"
    data     = data.azurerm_key_vault_certificate.appgateway_ssl_cert.certificate
    password = data.azurerm_key_vault_secret.ssl_certificate_password.value
  }

  frontend_port {
    name = "frontendPort"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "appGatewayFrontendIP"
    public_ip_address_id = azurerm_public_ip.example.id
  }

  backend_address_pool {
    name = "appGatewayBackendPool"
  }

  backend_http_settings {
    name                  = "appGatewayBackendHttpSettings"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 20
  }

  http_listener {
    name                           = "appGatewayHttpListener"
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    frontend_port_name             = "frontendPort"
    protocol                       = "Https"
    ssl_certificate_name           = "appgateway-ssl-cert"
  }

  url_path_map {
    name                           = "urlPathMap"
    default_backend_address_pool   = "appGatewayBackendPool"
    default_backend_http_settings  = "appGatewayBackendHttpSettings"
    path_rule {
      name                       = "examplePathRule"
      paths                      = ["/example/*"]
      backend_address_pool       = "appGatewayBackendPool"
      backend_http_settings_name = "appGatewayBackendHttpSettings"
    }
  }

  probes {
    name                = "exampleProbe"
    protocol            = "Http"
    path                = "/"
    interval            = 30
    timeout             = 30
    unhealthy_threshold = 3
    pick_host_name_from_backend_http_settings = true
    min_servers         = 0
    match {
      status_codes = ["200-399"]
    }
  }

  tags = {
    environment = "Production"
  }
}