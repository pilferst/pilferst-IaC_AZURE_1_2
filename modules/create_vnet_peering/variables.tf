variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "local_id" {
  description = "Local vnet id"
  type        = string
}

variable "local_name" {
  description = "Local vnet name"
  type        = string
}

variable "remote_id" {
  description = "Local vnet id"
  type        = string
}

variable "remote_name" {
  description = "Local vnet name"
  type        = string
}


variable "tags" {
  description = "Tags to apply to VNet and subnets"
  type        = map(string)
  default     = {}
}