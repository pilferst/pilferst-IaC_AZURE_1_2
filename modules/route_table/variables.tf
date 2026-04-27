variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Main location"
  type        = string
}


variable "name" {
  description = "Name of the Route Table"
  type        = string
}


variable "subnet_id" {
  description = "Subnet id"
  type        = string
}

variable "next_hop_in_ip_address" {
  description = "Next hop,ip address ofthe gateway"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}