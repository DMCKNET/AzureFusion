variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the VM"
  type        = string
}

variable "admin_username" {
  description = "Admin username from Key Vault"
  type        = string
}

variable "admin_password" {
  description = "Admin password from Key Vault"
  type        = string
  sensitive   = true
}

variable "nic_name" {
  description = "Network interface name"
  type        = string
}

variable "prefix" {
  description = "Resource name prefix"
  type        = string
}