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


module "create_vnet_peering" {
  resource_group_name = azurerm_resource_group.terraform_resource_group.name  
  for_each = {
    "hub-spoke1" = { local_key = "hub",    remote_key = "spoke1" }
    "hub-spoke2" = { local_key = "hub",    remote_key = "spoke2" }
  }
  

  source = "./modules/create_vnet_peering"
  local_id = local.peering_id_name[each.value.local_key].id
  local_name = local.peering_id_name[each.value.local_key].name

  remote_id = local.peering_id_name[each.value.remote_key].id
  remote_name =  local.peering_id_name[each.value.remote_key].name
  


}