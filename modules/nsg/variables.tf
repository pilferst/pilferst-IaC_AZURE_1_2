variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Main location"
  type        = string
}

variable "name" {
  description = "Name of the Network Security Group"
  type        = string
}


variable "subnet_id" {
  description = "ID of the subnet to associate NSG with"
  type        = string
}

variable "security_rules" {
  description = "List of security rules"
  type = list(object({
    name                         = string
    priority                     = number
    direction                    = string
    access                       = string
    protocol                     = string
    source_port_ranges           = optional(list(string), ["*"])
    destination_port_ranges      = optional(list(string), ["*"])
    source_address_prefixes      = optional(list(string), ["*"])
    destination_address_prefixes = optional(list(string), ["*"])
    description                  = optional(string, null)
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to NSG"
  type        = map(string)
  default     = {}
}