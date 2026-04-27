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
      nsg_name         = optional(string, null)
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

variable "nsg_rules" {
  description = "Map of NSG name → list of security rules"
  type = map(list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string

    # Ports
    source_port_ranges          = optional(list(string), ["*"])
    destination_port_ranges     = optional(list(string), ["*"])

    # prefixes
    source_address_prefixes      = optional(list(string), ["*"])
    destination_address_prefixes = optional(list(string), ["*"])

    # description
    description                 = optional(string, null)

    # extra
    source_application_security_group_ids      = optional(list(string), null)
    destination_application_security_group_ids = optional(list(string), null)
  })))
  default = {}
}

variable "next_hop_in_ip_address" {
  description = "ip address of the feature gateway"
  type = string
  default = "10.0.1.5"
}


variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}