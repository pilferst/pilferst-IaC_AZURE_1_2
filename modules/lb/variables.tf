variable "rg_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Main location"
  type        = string
}

variable "id" {
  description = "id of lb"
  type        = string
}

variable "subnet_id" {
  description = "id of subnet for lb"
  type        = string
}