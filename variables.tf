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

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_name_2" {
  description = "Name of the second virtual machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "nic_name" {
  description = "Network interface name"
  type        = string
}

variable "nic_name_2" {
  description = "Network interface name for the second VM"
  type        = string
}

variable "prefix" {
  description = "Resource name prefix"
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

variable "public_ip_names" {
  description = "The names of the public IP addresses"
  type        = map(string)
}

variable "bastion_host_name" {
  description = "The name of the Bastion Host"
  type        = string
}

variable "onprem_subnet_names" {
  description = "The names of the on-premise subnets"
  type        = map(string)
}

variable "onprem_vnet_name" {
  description = "The name of the on-premise Virtual Network"
  type        = string
}

variable "sql_server_name" {
  description = "The name of the SQL server"
  type        = string
}