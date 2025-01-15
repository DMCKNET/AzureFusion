resource "azurerm_application_gateway" "main" {
  name                = "${var.prefix}-app-gateway"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "appGatewayIpConfig"
    subnet_id = module.vnet.subnet_ids["webapp"]
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
    key_vault_secret_id = azurerm_key_vault_certificate.appgateway_ssl_cert.secret_id
  }

  http_listener {
    name                           = "appGatewayHttpListener"
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    frontend_port_name             = "httpPort"
    protocol                       = "Http"
  }

  http_listener {
    name                           = "appGatewayHttpsListener"
    frontend_ip_configuration_name = "appGatewayFrontendIP"
    frontend_port_name             = "httpsPort"
    protocol                       = "Https"
    ssl_certificate_name           = "appGatewaySslCert"
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
    name                = "urlPathMap"
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
  }

  redirect_configuration {
    name        = "httpToHttpsRedirectConfig"
    redirect_type = "Permanent"
    target_listener_name = "appGatewayHttpsListener"
    include_path = true
    include_query_string = true
  }

  waf_configuration {
    enabled            = true
    firewall_mode      = "Prevention"
    rule_set_type      = "OWASP"
    rule_set_version   = "3.2"
  }

  tags = {
    environment = "development"
  }
}