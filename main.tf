resource "azurerm_resource_group" "terraform_resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location_main
  tags     = local.tags
}


module "create_vnet_subnet" {
  for_each = var.vnets

  source = "./modules/vnet"

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
    "hub-spoke1" = { local_key = "hub", remote_key = "spoke1" }
    "hub-spoke2" = { local_key = "hub", remote_key = "spoke2" }
  }
  source     = "./modules/peering"
  local_id   = local.peering_id_name[each.value.local_key].id
  local_name = local.peering_id_name[each.value.local_key].name

  remote_id   = local.peering_id_name[each.value.remote_key].id
  remote_name = local.peering_id_name[each.value.remote_key].name
}

module "create_lb" {
  source = "./modules/lb"
  resource_group_name = azurerm_resource_group.terraform_resource_group.name
  location            = var.resource_group_location_main
  count = var.number_of_lb
  id = "${count.index}"
  subnet_id = local.lb_subnet_id
}

module "create_private_dns_zone" {
  source = "./modules/private_dns"
  resource_group_name = azurerm_resource_group.terraform_resource_group.name
  location            = var.resource_group_location_main
  private_dns_zone_name = var.private_dns_zone_name
  private_dns_zone_auto_registration =var.private_dns_zone_auto_registration
  server_subnet_id = local.server_subnet_id

}


module "nsg-frontend01" {
  source = "./modules/nsg"

  name                = "nsg-frontend01"
  location            = var.resource_group_location_main
  resource_group_name = azurerm_resource_group.terraform_resource_group.name
  subnet_id           = module.create_vnet_subnet["spoke1"].subnet_ids["frontend01"]
  security_rules      = lookup(var.nsg_rules, "nsg-frontend01", [])
  tags                = local.tags
}

module "nsg-frontend02" {
  source = "./modules/nsg"

  name                = "nsg-frontend02"
  location            = var.resource_group_location_main
  resource_group_name = azurerm_resource_group.terraform_resource_group.name
  subnet_id           = module.create_vnet_subnet["spoke1"].subnet_ids["frontend02"]
  security_rules      = lookup(var.nsg_rules, "nsg-frontend02", [])
  tags                = local.tags
}

module "force-tunnel-spoke2-backend01" {
  source = "./modules/route_table"

  name                = "rt-spoke2-backend01"
  location            = var.resource_group_location_main
  resource_group_name = azurerm_resource_group.terraform_resource_group.name
  subnet_id           = module.create_vnet_subnet["spoke2"].subnet_ids["backend01"]
  next_hop_in_ip_address = var.next_hop_in_ip_address
  tags                = local.tags
}

module "force-tunnel-spoke2-backend02" {
  source = "./modules/route_table"

  name                = "rt-spoke2-backend02"
  location            = var.resource_group_location_main
  resource_group_name = azurerm_resource_group.terraform_resource_group.name
  subnet_id           = module.create_vnet_subnet["spoke2"].subnet_ids["backend02"]
  next_hop_in_ip_address = var.next_hop_in_ip_address
  tags                = local.tags
}