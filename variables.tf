variable "resource_group_name" {
  description = "Resource group name for testing"
  type        = string
  default     = "rg-iac-azure-1-2"
}

variable "resource_group_location_main" {
  description = "Resource group location"
  type        = string
  default     = "westeurope"
  validation {
    condition     = contains(["eastus", "westeurope", "centralus", "northeurope"], var.resource_group_location_main)
    error_message = "Allowed regions: eastus, westeurope, centralus, northeurope."
  }
}

variable "vnets" {
  description = "Config for all vnets"
  type = map(object({
    name          = string
    address_space = list(string)
    subnets = map(object({
      name           = string
      address_prefix = list(string)
    }))
  }))
}

variable "number_of_lb" {
  description = "Number of load balancers"
  type        = number
  default     = 1
  validation {
    condition = (var.number_of_lb > 0 &&
    var.number_of_lb < 10)
    error_message = "Allowed values: integers from 1 to 9"
  }
}

variable "private_dns_zone_name" {
  description = "Private dns zone name"
  type        = string
  default     = "development.local"
}

variable "private_dns_zone_auto_registration" {
  description = "Private dns zone auto registration"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}