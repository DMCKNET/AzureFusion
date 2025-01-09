variable "subscription_id" {
  description = "The subscription ID for the Azure account"
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the Azure account"
  type        = string
}

variable "client_id" {
  description = "The client ID for the service principal"
  type        = string
}

variable "client_secret" {
  description = "The client secret for the service principal"
  type        = string
  sensitive   = true
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location for the Azure resources"
  type        = string
}

variable "vm_name" {
  description = "Virtual Machine name"
  type        = string
}

variable "nic_name" {
  description = "Network Interface name"
  type        = string
}

variable "prefix" {
  description = "Prefix for all resources"
  type        = string
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "key_vault_resource_group" {
  description = "Resource Group of the Key Vault"
  type        = string
}

variable "vnet_name" {
  description = "The name of the Virtual Network"
  type        = string
}

variable "address_space" {
  description = "The address space for the Virtual Network"
  type        = list(string)
}

variable "subnet_names" {
  description = "The names of the subnets"
  type        = map(string)
}

variable "public_ip_names" {
  description = "The names of the public IPs"
  type        = map(string)
}

variable "private_dns_zone_name" {
  description = "The name of the private DNS zone"
  type        = string
}

variable "private_dns_link_name" {
  description = "The name of the private DNS link"
  type        = string
}

variable "private_dns_record_name" {
  description = "The name of the private DNS record"
  type        = string
}

variable "local_network_gateway_name" {
  description = "The name of the local network gateway"
  type        = string
}

variable "vpn_connection_name" {
  description = "The name of the VPN connection"
  type        = string
}

variable "onprem_vnet_name" {
  description = "The name of the on-premises virtual network"
  type        = string
}

variable "onprem_address_space" {
  description = "The address space for the on-premises virtual network"
  type        = list(string)
}

variable "onprem_subnet_names" {
  description = "The names of the on-premises subnets"
  type        = map(string)
}

variable "sql_server_name" {
  description = "The name of the SQL server"
  type        = string
}

variable "sql_database_name" {
  description = "The name of the SQL database"
  type        = string
}

variable "bastion_host_name" {
  description = "The name of the Bastion host"
  type        = string
}

variable "lb_name" {
  description = "The name of the Load Balancer"
  type        = string
}

variable "lb_frontend_ip_name" {
  description = "The name of the Load Balancer frontend IP configuration"
  type        = string
}

variable "lb_backend_pool_name" {
  description = "The name of the Load Balancer backend address pool"
  type        = string
}

variable "lb_rule_name" {
  description = "The name of the Load Balancer rule"
  type        = string
}