variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  sensitive   = true
}

variable "sql_admin_username" {
  description = "SQL admin username"
  type        = string
}

variable "sql_admin_password" {
  description = "SQL admin password"
  type        = string
  sensitive   = true
}

variable "vpn_shared_key" {
  description = "VPN shared key"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "The tenant ID for your Azure subscription"
  type        = string
}

variable "subscription_id" {
  description = "The subscription ID for your Azure subscription"
  type        = string
}

variable "client_id" {
  description = "The client ID for your Azure service principal"
  type        = string
}

variable "client_secret" {
  description = "The client secret for your Azure service principal"
  type        = string
  sensitive   = true
}

variable "location" {
  description = "Azure region"
  type        = string
}
