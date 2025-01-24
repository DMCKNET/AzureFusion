resource "azurerm_user_assigned_identity" "appgw_identity" {
  name                = "appgw-identity"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_application_gateway" "main" {
  name                = "${var.prefix}-app-gateway"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.appgw_identity.id]
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = module.vnet.subnet_ids["appgateway"]
  }

  frontend_ip_configuration {
    name                 = "appGatewayFrontendIP"
    public_ip_address_id = azurerm_public_ip.app_gateway.id
  }

  frontend_port {
    name = "httpPort"
    port = 80
  }

  frontend_port {
    name = "httpsPort"
    port = 443
  }

  ssl_certificate {
    name                = "appGatewaySslCert"
    key_vault_secret_id = "https://azurefusionkeyvault.vault.azure.net/secrets/appgateway-ssl-cert/1cdf41fb3a1f44b5a10f9f5deedcc7fc"
  }

  http_listener {
    name                           = "appGatewayHttpListener"
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    frontend_port_name             = "httpsPort"
    ssl_certificate_name           = "appGatewaySslCert"
    protocol                       = "Https"
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

  url_path_map {
    name                             = "urlpathmap"
    default_backend_address_pool_name = "appGatewayBackendPool"
    default_backend_http_settings_name = "appGatewayBackendHttpSettings"

    path_rule {
      name                       = "defaultRule"
      paths                      = ["/*"]
      backend_address_pool_name  = "appGatewayBackendPool"
      backend_http_settings_name = "appGatewayBackendHttpSettings"
    }
  }

  request_routing_rule {
    name                       = "httpToHttpsRedirect"
    rule_type                  = "Basic"
    http_listener_name         = "appGatewayHttpListener"
    redirect_configuration_name = "httpToHttpsRedirectConfig"
    priority                   = 100
  }

  redirect_configuration {
    name                 = "httpToHttpsRedirectConfig"
    redirect_type        = "Permanent"
    target_listener_name = "appGatewayHttpListenerRedirect"
    include_path         = true
    include_query_string = true
  }

  http_listener {
    name                           = "appGatewayHttpListenerRedirect"
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    frontend_port_name             = "httpPort"
    protocol                       = "Http"
  }

  waf_configuration {
    enabled            = true
    firewall_mode      = "Prevention"
    rule_set_type      = "OWASP"
    rule_set_version   = "3.2"
  }

  probe {
    name                = "exampleProbe"
    protocol            = "Http"
    path                = "/"
    interval            = 30
    timeout             = 30
    unhealthy_threshold = 3
    pick_host_name_from_backend_http_settings = true
    match {
      status_code = ["200-399"]
    }
  }

  tags = {
    environment = "Production"
  }
}