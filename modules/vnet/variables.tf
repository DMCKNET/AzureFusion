variable "location" {
  description = "The location for your Azure resources"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
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