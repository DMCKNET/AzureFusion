variable "location" {
  description = "The location for your Azure resources"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "nsg_names" {
  description = "Network Security Group names"
  type        = map(string)
}

variable "subnet_ids" {
  description = "Subnet IDs for the Network Security Groups"
  type        = map(string)
}

variable "subnet_prefixes" {
  description = "Subnet prefixes for the Network Security Groups"
  type        = map(string)
}