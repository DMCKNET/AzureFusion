variable "subscription_id" {
  description = "The subscription ID for the Azure account"
  type        = string
}

variable "tenant_id" {
  description = "The tenant ID for the Azure account"
  type        = string
}

variable "client_id" {
  description = "The client ID for the Azure account"
  type        = string
}

variable "client_secret" {
  description = "The client secret for the Azure account"
  type        = string
  sensitive   = true
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The location for the resources"
  type        = string
}

variable "prefix" {
  description = "Resource name prefix"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "subnet_names" {
  description = "The names of the subnets"
  type        = map(string)
}

variable "key_vault_name" {
  description = "The name of the Key Vault"
  type        = string
}

variable "key_vault_resource_group" {
  description = "The resource group name for the Key Vault"
  type        = string
}

variable "onprem_subnet_names" {
  description = "The names of the on-premise subnets"
  type        = map(string)
}

variable "onprem_vnet_name" {
  description = "The name of the on-premise virtual network"
  type        = string
}

variable "bastion_host_name" {
  description = "The name of the Bastion Host"
  type        = string
}

variable "lb_name" {
  description = "The name of the Load Balancer"
  type        = string
}

variable "lb_frontend_ip_name" {
  description = "The name of the Load Balancer Frontend IP Configuration"
  type        = string
}

variable "lb_backend_pool_name" {
  description = "The name of the Load Balancer Backend Pool"
  type        = string
}

variable "nic_name" {
  description = "The name of the Network Interface"
  type        = string
}

variable "nic_name_2" {
  description = "The name of the second Network Interface"
  type        = string
}

variable "sql_server_name" {
  description = "The name of the SQL Server"
  type        = string
}

variable "vm_name" {
  description = "The name of the Virtual Machine"
  type        = string
}

variable "vm_size" {
  description = "The size of the Virtual Machine"
  type        = string
}

variable "vm_name_2" {
  description = "The name of the second Virtual Machine"
  type        = string
}
variable "lb_rule_name" {
  description = "The name of the Load Balancer Rule"
  type        = string
}
variable "public_ip_names" {
  description = "The names of the public IP addresses"
  type        = map(string)
}
variable "service_principal_object_id" {
  description = "The object ID of the service principal."
  type        = string
}
variable "main_vnet_id" {
  description = "The ID of the main virtual network"
}

variable "onprem_vnet_id" {
  description = "The ID of the on-prem virtual network"
}
variable "storage_account_name" {
  description = "Storage Account name"
  type        = string
}