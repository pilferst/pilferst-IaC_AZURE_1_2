variable "rg_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Main location"
  type        = string
}

variable "private_dns_zone_name" {
  description = "Private dns zone"
  type        = string
}

variable "private_dns_zone_auto_registration" {
  description = "Private dns zone auto registration"
  type        = bool
}

variable "server_subnet_id" {
  description = "subnet id for dns connection"
  type        = map(any)
}