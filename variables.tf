variable "location" {
  description = "The Azure Region in which all resources in this example should be created."
  default     = "East US"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  default     = "example-resources"
}

variable "tenant_id" {
  description = "The tenant ID for your Azure subscription"
  default     = "9ad50b1c-d7aa-46a5-96a9-6509fcc6b905"
}
