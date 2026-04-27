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


variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}