resource "azurerm_resource_group" "terraform_resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location_main
  tags     = local.tags
}


module "create_vnet_subnet" {
  for_each = var.vnets

  source = "./modules/create_vnet_subnet"

  name                = each.value.name
  location            = var.resource_group_location_main
  resource_group_name = azurerm_resource_group.terraform_resource_group.name
  address_space       = each.value.address_space
  subnets             = each.value.subnets
  tags                = local.tags
}